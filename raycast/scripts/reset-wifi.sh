#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Reset WiFi
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🛜

# Documentation:
# @raycast.author George Gillams
# @raycast.authorURL https://www.georgegillams.co.uk/

networksetup -setairportpower Wi-Fi off
networksetup -setairportpower Wi-Fi on