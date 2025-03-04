#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Power back on
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ⚡️

# Documentation:
# @raycast.author George Gillams
# @raycast.authorURL https://www.georgegillams.co.uk/

networksetup -setnetworkserviceenabled "USB 10/100/1000 LAN" on