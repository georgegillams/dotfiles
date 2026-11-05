#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/teams-lib.sh"

teams_focus_applescript() {
    cat <<APPLESCRIPT
tell application "System Events"
    set teamsProcesses to every process whose name contains "Teams"
    repeat with proc in teamsProcesses
        set meetingWindows to every window of proc whose $TEAMS_MEETING_WINDOW_FILTER
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
    # Backgrounded: warming can take up to ~30s and focus shouldn't wait on it.
    "$(dirname "${BASH_SOURCE[0]}")/teams-warm-ax.sh" >/dev/null 2>&1 &
fi
