#!/bin/bash

osascript <<'EOF'
if application "Amphetamine" is running then
    tell application "Amphetamine" to end session
end if
EOF
