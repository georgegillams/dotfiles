#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open new iTerm window
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖥

# Documentation:
# @raycast.author George Gillams
# @raycast.authorURL https://www.georgegillams.co.uk/

tell application "iTerm"
    create window with default profile
end tell
