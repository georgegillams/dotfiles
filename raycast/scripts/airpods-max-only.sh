#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title AirPods Max only
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🎧

# Documentation:
# @raycast.author George Gillams
# @raycast.authorURL https://www.georgegillams.co.uk/

# open /Applications/OBSBOT_WebCam.app
osascript -e 'tell application "Music" to pause'
SwitchAudioSource -s "George’s AirPods Max" -t input & SwitchAudioSource -s "George’s AirPods Max" -t output