#!/bin/bash

# osascript -e 'tell application "Microsoft Teams" to activate' -e 'delay 0.2' -e 'tell application "System Events" to keystroke "m" using {command down, shift down}'

osascript <<'EOF'
tell application "System Events"
    set activeApp to name of first application process whose frontmost is true
end tell

set teamsAppName to "Microsoft Teams"

if activeApp does not contain "Teams" then
    -- Teams is not focused
    tell application teamsAppName to activate
    delay 0.2
end if

tell application "System Events"
    keystroke "m" using {shift down, command down}
end tell

EOF