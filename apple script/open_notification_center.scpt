#!/usr/bin/osascript
on run argv
  display notification "It's time to check your battery levels. 🪫 Notification center will open imminently!" with title "🪫 Battery check time!"

  delay 2

  tell application "System Events"
        key down 63
        key down "n"
        key up "n"
        key up 63
  end tell
end run