#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Mic and AirPods
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ./mic-and-airpods.png

# Documentation:
# @raycast.author George Gillams
# @raycast.authorURL https://www.georgegillams.co.uk/

# open /Applications/OBSBOT_WebCam.app
SwitchAudioSource -s "RØDE VideoMic GO II" -t input & SwitchAudioSource -s "George’s AirPods Pro" -t output
shortcuts run 'Video lights on'
