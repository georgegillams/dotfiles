#!/usr/bin/osascript
on run argv
  tell app "System Events" to display dialog "It's time to check your battery levels. 🪫" with title "🪫 Battery check time!" buttons {"Not now", "OK"} default button 1
  if button returned of result is "Not now" then
    return
  end if

  tell application "System Events"
        key down 63
        key down "n"
        key up "n"
        key up 63
  end tell
end run