#!/bin/bash

osascript <<'EOF'
tell application "System Events"
    set teamsProcesses to every process whose name contains "Teams"
    repeat with proc in teamsProcesses
        set meetingWindows to every window of proc whose name contains "| Microsoft Teams"
        if (count of meetingWindows) > 0 then
            if frontmost of proc is false then
                set frontmost of proc to true
                perform action "AXRaise" of item 1 of meetingWindows
                # delay 0.2
            end if
            tell proc to keystroke "o" using {shift down, command down}
        end if
    end repeat
end tell
EOF
