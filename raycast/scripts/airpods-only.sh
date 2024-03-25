#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title AirPods only
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ./airpods.png

# Documentation:
# @raycast.author George Gillams
# @raycast.authorURL https://www.georgegillams.co.uk/

# open /Applications/OBSBOT_WebCam.app
SwitchAudioSource -s "George’s AirPods Pro" -t input & SwitchAudioSource -s "George’s AirPods Pro" -t output