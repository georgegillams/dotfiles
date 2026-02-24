#!/bin/bash

# 🙂 = U+1F642, UTF-8 bytes as octal (avoids encoding issues)
printf '\360\237\231\202\n' | pbcopy
osascript -e 'tell application "System Events" to keystroke "v" using command down'