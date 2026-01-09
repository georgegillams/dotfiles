#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Obsbot toggle tracking
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 📹

# Documentation:
# @raycast.author George Gillams
# @raycast.authorURL https://www.georgegillams.co.uk/

# Open app
open "/Applications/OBSBOT_Center.app"

# Wait for app to open
sleep 10

# # Open again to ensure focus
open "/Applications/OBSBOT_Center.app"

# # Focus obs app with apple script
# osascript -e 'tell application "OBSBOT_Center" to activate'

# Press option+L to toggle tracking
# osascript -e 'tell application "System Events" to keystroke "l" using option down'
# Find app name with osascript -e 'tell application "System Events" to get displayed name of (first process whose frontmost is true)'
osascript -e 'tell application "OBSBOT Center" to activate' -e 'tell application "System Events" to keystroke "l" using option down'

