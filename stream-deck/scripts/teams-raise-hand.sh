#!/bin/bash

osascript -e 'tell application "Microsoft Teams" to activate' -e 'delay 0.3' -e 'tell application "System Events" to keystroke "k" using {command down, shift down}'
