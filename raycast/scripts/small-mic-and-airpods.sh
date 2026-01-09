#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Small Mic and AirPods
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ./small-mic-and-airpods.png

# Documentation:
# @raycast.author George Gillams
# @raycast.authorURL https://www.georgegillams.co.uk/

# open /Applications/OBSBOT_WebCam.app
osascript -e 'tell application "Music" to pause'
SwitchAudioSource -s "External Microphone" -t input & SwitchAudioSource -s "George’s AirPods Pro" -t output
