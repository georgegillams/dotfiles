#!/bin/bash

source "$(dirname "$0")/teams-focus.sh"

osascript <<EOF
$(teams_focus_applescript)
tell application "System Events" to keystroke "e" using {shift down, command down}
EOF
