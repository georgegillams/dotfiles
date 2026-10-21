#!/bin/bash
# Shared helpers for the teams-*.sh scripts. Source, don't run.

# AppleScript `whose` clause matching Teams meeting windows. Meeting titles are
# arbitrary, so instead exclude the main window's known titles.
TEAMS_MEETING_WINDOW_FILTER='name is not "" and name does not start with "Activity |" and name does not start with "Chat |" and name is not "Calendar" and name does not start with "Calendar |" and name is not "Calls" and name does not start with "Calls |"'

# Focus the meeting window, then send Cmd+Shift+<key> to it.
teams_meeting_shortcut() {
    local key="$1"
    osascript <<EOF
tell application "System Events"
    set teamsProcesses to every process whose name contains "Teams"
    repeat with proc in teamsProcesses
        set meetingWindows to every window of proc whose $TEAMS_MEETING_WINDOW_FILTER
        if (count of meetingWindows) > 0 then
            if frontmost of proc is false then
                set frontmost of proc to true
                perform action "AXRaise" of item 1 of meetingWindows
                # delay 0.2
            end if
            tell proc to keystroke "$key" using {shift down, command down}
        end if
    end repeat
end tell
EOF
}
