#!/usr/bin/osascript
on run argv
  tell application "System Events"
        key down 63
        key down "n"
        key up "n"
        key up 63
  end tell
end run