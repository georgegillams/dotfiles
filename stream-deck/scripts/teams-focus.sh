#!/bin/bash

teams_focus_applescript() {
    cat <<'APPLESCRIPT'
tell application "System Events"
    set teamsProcesses to every process whose name contains "Teams"
    repeat with proc in teamsProcesses
        set callWindows to every window of proc whose name does not contain "Calendar |" and name is not ""
        if (count of callWindows) > 0 then
            set needsDelay to frontmost of proc is false
            set frontmost of proc to true
            perform action "AXRaise" of item 1 of callWindows
            if needsDelay then delay 0.2
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
