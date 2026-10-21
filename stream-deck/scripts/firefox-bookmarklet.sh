#!/bin/bash

# Click a bookmarklet in the Firefox bookmarks toolbar, either directly on the
# toolbar or inside its "Bookmarklets" folder.
# Usage: firefox-bookmarklet.sh "🌓 Invert webpage"
# Requires the bookmarks toolbar to be visible.

if [ -z "$1" ]; then
    echo "Usage: $0 <bookmarklet name>" >&2
    exit 1
fi

osascript - "$1" <<'EOF'
on run argv
    set bookmarkName to item 1 of argv
    set folderName to "Bookmarklets"

    tell application "Firefox" to activate
    tell application "System Events"
        tell process "firefox"
            set frontmost to true
            set bookmarksBar to first toolbar of group 1 of front window whose description is "Bookmarks"

            set directMatches to (buttons of bookmarksBar whose description is bookmarkName)
            if (count of directMatches) > 0 then
                click item 1 of directMatches
                return
            end if

            set folderButton to first button of bookmarksBar whose description is folderName
            click folderButton
            repeat 20 times
                try
                    set folderMenu to menu 1 of folderButton
                    click (first menu item of folderMenu whose name is bookmarkName or description is bookmarkName)
                    return
                end try
                delay 0.05
            end repeat

            key code 53 -- Escape, to close the folder menu
            error "Bookmarklet not found: " & bookmarkName
        end tell
    end tell
end run
EOF
