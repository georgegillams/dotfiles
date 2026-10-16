#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Mic and AirPods
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ./mic-and-airpods-max.png

# Documentation:
# @raycast.author George Gillams
# @raycast.authorURL https://www.georgegillams.co.uk/

SWITCH="/Users/george.gillams/Documents/github.com/georgegillams/dotfiles/stream-deck/scripts/switch-audio.sh"
DEVICES=$("$SWITCH" -l)

# Mic preference: RØDE > DJI > AirPods Max > AirPods Pro
if echo "$DEVICES" | grep -q "RØDE VideoMic GO II"; then
    MIC="RØDE VideoMic GO II"
elif echo "$DEVICES" | grep -q "DJI MIC MINI"; then
    MIC="DJI MIC MINI"
elif echo "$DEVICES" | grep -q "George's AirPods Max - Find My"; then
    MIC="George's AirPods Max"
elif echo "$DEVICES" | grep -q "George's AirPods Pro - Find My"; then
    MIC="George's AirPods Pro"
else
    MIC=""
fi

# Output preference: AirPods Max > AirPods Pro
if echo "$DEVICES" | grep -q "George's AirPods Max"; then
    OUTPUT="George's AirPods Max"
elif echo "$DEVICES" | grep -q "George's AirPods Pro"; then
    OUTPUT="George's AirPods Pro"
else
    OUTPUT=""
fi

[ -n "$MIC" ] && "$SWITCH" -s "$MIC" -t input &
[ -n "$OUTPUT" ] && "$SWITCH" -s "$OUTPUT" -t output &
wait
