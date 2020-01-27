on run argv
  tell application "/Applications/zoom.us.app" to activate
  tell application "System Events" to tell process "zoom.us"
      click menu item "Join meeting..." of menu 1 of menu bar item "zoom.us" of menu bar 1
  end tell
  tell application "System Events"
    delay 1
    set textToType to "" & item 1 of argv
    keystroke textToType
    delay 1
    keystroke return
  end tell
end run
