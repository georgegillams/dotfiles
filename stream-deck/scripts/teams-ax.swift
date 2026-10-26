// Control Microsoft Teams (new Teams / MSTeams) meeting buttons via the Accessibility API.
// Compiled on first use by teams-ax.sh.
// Usage: teams-ax toggle-mute | mute | unmute | camera | raise | leave | react <label> | react-probe | dump
import AppKit
import ApplicationServices

let buttonRoles: Set<String> = ["AXButton", "AXMenuButton", "AXCheckBox", "AXMenuItem", "AXPopUpButton"]
let fetchAttrs = ["AXRole", "AXTitle", "AXDescription", "AXChildren"] as CFArray

struct Node {
    let element: AXUIElement
    let role: String
    let label: String
    let children: [AXUIElement]
}

func fail(_ msg: String) -> Never {
    FileHandle.standardError.write((msg + "\n").data(using: .utf8)!)
    exit(1)
}

// One IPC round trip per element instead of one per attribute.
func node(_ e: AXUIElement) -> Node? {
    var values: CFArray?
    guard AXUIElementCopyMultipleAttributeValues(e, fetchAttrs, [], &values) == .success,
          let vals = values as? [AnyObject], vals.count == 4 else { return nil }
    let role = vals[0] as? String ?? ""
    let title = vals[1] as? String ?? ""
    let desc = vals[2] as? String ?? ""
    let children = vals[3] as? [AXUIElement] ?? []
    return Node(element: e, role: role, label: title.isEmpty ? desc : title, children: children)
}

func teamsApp() -> AXUIElement {
    guard AXIsProcessTrusted() else {
        fail("This process is not trusted for Accessibility (System Settings → Privacy & Security → Accessibility)")
    }
    guard let app = NSRunningApplication.runningApplications(withBundleIdentifier: "com.microsoft.teams2").first else {
        fail("MSTeams not running")
    }
    let ax = AXUIElementCreateApplication(app.processIdentifier)
    AXUIElementSetMessagingTimeout(ax, 2.0)
    AXUIElementSetAttributeValue(ax, "AXEnhancedUserInterface" as CFString, kCFBooleanTrue)
    return ax
}

func windows(_ app: AXUIElement) -> [AXUIElement] {
    var v: AnyObject?
    guard AXUIElementCopyAttributeValue(app, kAXWindowsAttribute as CFString, &v) == .success else { return [] }
    return v as? [AXUIElement] ?? []
}

// Depth-first; visits later children first because the meeting toolbar sits near the end of the tree.
func walk(_ root: AXUIElement, _ visit: (Node) -> Bool) {
    var stack = [root]
    while let e = stack.popLast() {
        guard let n = node(e) else { continue }
        if visit(n) { return }
        stack.append(contentsOf: n.children)
    }
}

func find(_ app: AXUIElement, _ labels: [String]) -> Node? {
    for w in windows(app) {
        var found: Node?
        walk(w) { n in
            if buttonRoles.contains(n.role), labels.contains(where: { n.label.hasPrefix($0) }) {
                found = n
                return true
            }
            return false
        }
        if let found { return found }
    }
    return nil
}

func press(_ app: AXUIElement, _ labels: [String]) -> String {
    guard let n = find(app, labels) else { fail("Button not found: \(labels.joined(separator: " / "))") }
    let err = AXUIElementPerformAction(n.element, kAXPressAction as CFString)
    guard err == .success else { fail("Press failed on \(n.label): \(err.rawValue)") }
    return "Pressed: \(n.label)"
}

func dumpButtons(_ app: AXUIElement) {
    for w in windows(app) {
        walk(w) { n in
            if buttonRoles.contains(n.role) { print("[\(n.role)] \(n.label)") }
            return false
        }
    }
}

let args = CommandLine.arguments.dropFirst()
guard let cmd = args.first else {
    fail("Usage: teams-ax toggle-mute | mute | unmute | camera | raise | leave | react <label> | react-probe | dump")
}
let app = teamsApp()

switch cmd {
case "toggle-mute": print(press(app, ["Mute mic", "Unmute mic"]))
case "mute":
    if find(app, ["Unmute mic"]) != nil { print("Already muted") } else { print(press(app, ["Mute mic"])) }
case "unmute":
    if find(app, ["Mute mic"]) != nil { print("Already unmuted") } else { print(press(app, ["Unmute mic"])) }
case "camera": print(press(app, ["Turn camera on", "Turn camera off"]))
case "raise": print(press(app, ["Raise", "Lower"]))
case "leave": print(press(app, ["Leave"]))
case "dump": dumpButtons(app)
case "react-probe":
    print(press(app, ["React"]))
    Thread.sleep(forTimeInterval: 0.7)
    dumpButtons(app)
case "react":
    guard args.count >= 2 else { fail("Usage: teams-ax react <label>") }
    print(press(app, ["React"]))
    Thread.sleep(forTimeInterval: 0.7)
    print(press(app, [args[args.startIndex + 1]]))
default: fail("Unknown command: \(cmd)")
}
