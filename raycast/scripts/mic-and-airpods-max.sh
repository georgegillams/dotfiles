#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Mic and AirPods Max
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ./mic-and-airpods-max.png

# Documentation:
# @raycast.author George Gillams
# @raycast.authorURL https://www.georgegillams.co.uk/

# open /Applications/OBSBOT_WebCam.app
shortcuts run 'SetState.Activate.VideoLights'
osascript -e 'tell application "Music" to pause'
SwitchAudioSource -s "RØDE VideoMic GO II" -t input & SwitchAudioSource -s "George’s AirPods Max" -t output
open /Applications/OBSBOT_Center.app/
