#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/teams-lib.sh"

if ! system_profiler SPDisplaysDataType | grep -qi "LS27D70xE"; then
    exit 0
fi

# Find the second LS27D70xE display (vendor=0x4c2d, product=0x768b) sorted by display ID
DISPLAY_ORIGIN=$(swift -e '
import CoreGraphics
let maxDisplays: UInt32 = 10
var displayIDs = [CGDirectDisplayID](repeating: 0, count: Int(maxDisplays))
var displayCount: UInt32 = 0
CGGetActiveDisplayList(maxDisplays, &displayIDs, &displayCount)

var ls27Displays: [(CGDirectDisplayID, CGRect)] = []
for i in 0..<Int(displayCount) {
    let id = displayIDs[i]
    if CGDisplayVendorNumber(id) == 0x4c2d && CGDisplayModelNumber(id) == 0x768b {
        ls27Displays.append((id, CGDisplayBounds(id)))
    }
}
ls27Displays.sort { $0.0 < $1.0 }
if ls27Displays.count >= 2 {
    let b = ls27Displays[1].1
    print("\(Int(b.origin.x)) \(Int(b.origin.y))")
}
' 2>/dev/null)

if [ -z "$DISPLAY_ORIGIN" ]; then
    exit 0
fi

DISPLAY_X=$(echo "$DISPLAY_ORIGIN" | awk '{print $1}')
DISPLAY_Y=$(echo "$DISPLAY_ORIGIN" | awk '{print $2}')

osascript << EOF
set displayX to $DISPLAY_X
set displayY to $DISPLAY_Y

tell application "System Events"
    set teamsProcesses to every process whose name contains "Teams"
    repeat with proc in teamsProcesses
        set callWindows to every window of proc whose $TEAMS_MEETING_WINDOW_FILTER
        repeat with w in callWindows
            set position of w to {displayX, displayY}
        end repeat
    end repeat
end tell
EOF
