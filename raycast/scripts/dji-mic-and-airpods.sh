#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title DJI Mic and AirPods
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ./dji-mic-and-airpods.png

# Documentation:
# @raycast.author George Gillams
# @raycast.authorURL https://www.georgegillams.co.uk/

# open /Applications/OBSBOT_WebCam.app
SwitchAudioSource -s "DJI Microphone" -t input & SwitchAudioSource -s "George’s AirPods Pro" -t output
