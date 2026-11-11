#!/bin/bash

# Click a bookmarklet in the Firefox bookmarks toolbar: directly on the toolbar,
# inside its "Bookmarklets" folder, or in the overflow ("Show more bookmarks")
# menu when the toolbar is too narrow to show it.
# Usage: firefox-bookmarklet.sh "🌓 Invert webpage"
# Requires the bookmarks toolbar to be visible.
#
# Not a Raycast script command itself; Raycast wrappers call it by path.
#
# Firefox's accessibility tree has changed between versions (e.g. the bookmark
# title moved from AXDescription to AXTitle), so nothing here relies on exact
# paths or attributes:
#   - toolbars are found by walking the window, not by a fixed index;
#   - elements match on any of their title/description/value/help, ignoring
#     case and emoji variation selectors, falling back to a substring match;
#   - role checks are avoided where possible, so a button becoming a menu
#     button or gaining a wrapper group still works.
#
# Set FIREFOX_BUNDLE_ID to target another build, e.g. org.mozilla.nightly.

if [ -z "$1" ]; then
    echo "Usage: $0 <bookmarklet name>" >&2
    exit 1
fi

osascript - "$1" "${FIREFOX_BUNDLE_ID:-org.mozilla.firefox}" <<'EOF'
property folderName : "Bookmarklets"
property overflowLabel : "more bookmarks"
-- Roles whose subtrees are web content or otherwise can't contain the toolbar.
-- Skipping them keeps the walk fast on heavy pages.
property skipRoles : {"AXWebArea", "AXScrollArea", "AXButton", "AXMenuButton", "AXPopUpButton", "AXTextField", "AXComboBox", "AXStaticText", "AXImage", "AXMenu", "AXMenuItem"}

on run argv
    set wanted to my normalise(item 1 of argv)
    set bundleId to item 2 of argv

    tell application id bundleId to activate
    tell application "System Events"
        set proc to first application process whose bundle identifier is bundleId
        set frontmost of proc to true

        -- Use the frontmost window that has toolbars, so devtools or
        -- picture-in-picture windows in front don't break things, but a
        -- bookmarklet never runs against a background browser window.
        set toolbarList to {}
        repeat with w in (windows of proc)
            set toolbarList to my collectToolbars(contents of w, 4)
            if toolbarList is not {} then exit repeat
        end repeat
        if toolbarList is {} then error "No Firefox window with toolbars found. Is a browser window open?"
    end tell

    set toolbarList to my bookmarksToolbarsFirst(toolbarList)

    -- 1. Directly on a toolbar.
    repeat with tb in toolbarList
        set hit to my findIn(my toolbarItems(contents of tb), wanted)
        if hit is not missing value then
            my press(hit)
            return
        end if
    end repeat

    -- 2. In the bookmarklets folder, then 3. in the overflow menu (which may
    -- itself hold the folder, so look one submenu deep).
    set folderWanted to my normalise(folderName)
    repeat with labelWanted in {folderWanted, overflowLabel}
        repeat with tb in toolbarList
            set opener to my findIn(my toolbarItems(contents of tb), contents of labelWanted)
            if opener is not missing value then
                if my clickInMenu(opener, wanted, folderWanted) then return
            end if
        end repeat
    end repeat

    error "Bookmarklet not found: " & (item 1 of argv) & ". Toolbar items seen: " & my describeToolbars(toolbarList)
end run

-- Walk the window for toolbars, up to maxDepth levels down.
on collectToolbars(parentElement, maxDepth)
    set found to {}
    tell application "System Events"
        set kids to {}
        try
            set kids to UI elements of parentElement
        end try
        repeat with k in kids
            set k to contents of k
            set r to ""
            try
                set r to role of k
            end try
            if r is "AXToolbar" then
                set end of found to k
            else if maxDepth > 1 and r is not in skipRoles then
                set found to found & my collectToolbars(k, maxDepth - 1)
            end if
        end repeat
    end tell
    return found
end collectToolbars

on bookmarksToolbarsFirst(toolbarList)
    set preferred to {}
    set others to {}
    repeat with tb in toolbarList
        set isBookmarks to false
        repeat with l in my labelsOf(contents of tb)
            if contents of l contains "bookmark" then set isBookmarks to true
        end repeat
        if isBookmarks then
            set end of preferred to contents of tb
        else
            set end of others to contents of tb
        end if
    end repeat
    return preferred & others
end bookmarksToolbarsFirst

-- A toolbar's items, plus the children of any wrapper groups inside it.
on toolbarItems(tb)
    set out to {}
    tell application "System Events"
        set kids to {}
        try
            set kids to UI elements of tb
        end try
        repeat with k in kids
            set k to contents of k
            set end of out to k
            set r to ""
            try
                set r to role of k
            end try
            if r is "AXGroup" then
                try
                    set out to out & (UI elements of k)
                end try
            end if
        end repeat
    end tell
    return out
end toolbarItems

-- Open opener's menu and click wanted in it, or in a folderWanted submenu.
-- Closes the menu and returns false if it isn't there.
on clickInMenu(opener, wanted, folderWanted)
    my press(opener)
    set theMenu to my waitForMenu(opener)
    if theMenu is missing value then
        my closeMenus()
        return false
    end if

    set entries to my menuEntries(theMenu)
    set hit to my findIn(entries, wanted)
    if hit is missing value then
        set folderEntry to my findIn(entries, folderWanted)
        if folderEntry is not missing value then
            my press(folderEntry)
            set subMenu to my waitForMenu(folderEntry)
            if subMenu is not missing value then set hit to my findIn(my menuEntries(subMenu), wanted)
        end if
    end if

    if hit is missing value then
        my closeMenus()
        return false
    end if
    my press(hit)
    return true
end clickInMenu

on waitForMenu(opener)
    tell application "System Events"
        repeat 40 times
            try
                repeat with k in (UI elements of opener)
                    if role of k is "AXMenu" then return contents of k
                end repeat
            end try
            delay 0.05
        end repeat
    end tell
    return missing value
end waitForMenu

on menuEntries(theMenu)
    tell application "System Events"
        try
            return UI elements of theMenu
        end try
    end tell
    return {}
end menuEntries

on closeMenus()
    tell application "System Events" to key code 53 -- Escape
end closeMenus

on press(e)
    tell application "System Events"
        try
            click e
        on error
            perform action "AXPress" of e
        end try
    end tell
end press

-- First element with a label equal to wanted, else the first whose label
-- contains it (copes with Firefox adding a prefix/suffix to labels).
on findIn(elementList, wanted)
    if wanted is "" then return missing value
    set fuzzy to missing value
    repeat with e in elementList
        repeat with l in my labelsOf(contents of e)
            set l to contents of l
            if l is wanted then return contents of e
            if fuzzy is missing value and l contains wanted then set fuzzy to contents of e
        end repeat
    end repeat
    return fuzzy
end findIn

-- Every text attribute an element might carry its label in, normalised.
on labelsOf(e)
    set out to {}
    tell application "System Events"
        repeat with attr in {"AXTitle", "AXDescription", "AXValue", "AXHelp"}
            try
                set v to value of attribute (contents of attr) of e
                if v is not missing value then
                    set v to my normalise(v as text)
                    if v is not "" and v is not "button" then set end of out to v
                end if
            end try
        end repeat
    end tell
    return out
end labelsOf

-- Drop emoji variation selectors (so "🏷️" matches "🏷") and trim whitespace.
-- AppleScript comparisons already ignore case.
on normalise(t)
    set saved to AppleScript's text item delimiters
    set AppleScript's text item delimiters to {character id 65039, character id 65038}
    set parts to text items of t
    set AppleScript's text item delimiters to ""
    set t to parts as text
    set AppleScript's text item delimiters to saved
    repeat while t starts with " " or t starts with tab
        if length of t is 1 then return ""
        set t to text 2 thru -1 of t
    end repeat
    repeat while t ends with " " or t ends with tab
        if length of t is 1 then return ""
        set t to text 1 thru -2 of t
    end repeat
    return t
end normalise

on describeToolbars(toolbarList)
    set seen to {}
    repeat with tb in toolbarList
        repeat with e in my toolbarItems(contents of tb)
            set ls to my labelsOf(contents of e)
            if ls is not {} then set end of seen to item 1 of ls
        end repeat
    end repeat
    set saved to AppleScript's text item delimiters
    set AppleScript's text item delimiters to ", "
    set s to seen as text
    set AppleScript's text item delimiters to saved
    return s
end describeToolbars
EOF
