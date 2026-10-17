#!/bin/bash

osascript <<'EOF'
if application "Amphetamine" is not running then
    tell application "Amphetamine" to activate
    delay 2
end if

tell application "Amphetamine" to start new session
EOF
