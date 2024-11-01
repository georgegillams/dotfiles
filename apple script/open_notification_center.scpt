#!/usr/bin/osascript
on run argv
  tell application "System Events"
        key down 63
        key down "n"
        key up "n"
  end tell
end run