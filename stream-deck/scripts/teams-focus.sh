#!/bin/bash

teams_focus_applescript() {
    cat <<'APPLESCRIPT'
tell application "System Events"
    set teamsProcesses to every process whose name contains "Teams"
    repeat with proc in teamsProcesses
        set meetingWindows to every window of proc whose name contains "| Microsoft Teams"
        if (count of meetingWindows) > 0 then
            set frontmost of proc to true
            perform action "AXRaise" of item 1 of meetingWindows
        end if
    end repeat
end tell
APPLESCRIPT
}

# When run directly, just focus
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    osascript <<EOF
$(teams_focus_applescript)
EOF
fi
