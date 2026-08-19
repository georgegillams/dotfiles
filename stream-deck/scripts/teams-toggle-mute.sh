#!/bin/bash

osascript -e 'tell application "Microsoft Teams" to activate' -e 'delay 0.2' -e 'tell application "System Events" to keystroke "m" using {command down, shift down}'
