#!/bin/bash

RESOURCES="/Users/george.gillams/Documents/github.com/georgegillams/dotfiles/resources"
PLAY="/Users/george.gillams/Documents/github.com/georgegillams/dotfiles/stream-deck/scripts/play-on-device.swift"
FIXED_VOL=40
PREV_VOL=$(osascript -e "get output volume of (get volume settings)")
osascript -e "set volume output volume $FIXED_VOL"
swift "$PLAY" "$RESOURCES/Unlock me.mp3" "MacBook Pro Speakers"
osascript -e "set volume output volume $PREV_VOL"
