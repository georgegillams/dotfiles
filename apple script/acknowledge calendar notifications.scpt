on run argv
  tell application "/System/Applications/Calendar.app" to activate
  tell application "System Events" to tell process "Calendar"
      click menu item "Show Notifications" of menu 1 of menu bar item "View" of menu bar 1
  end tell
  delay 2
  repeat while true
    tell application "System Events" to tell process "Calendar"
      # UI elements of radio group 1 of UI element 1 of row 1 of table 1 of scroll area 1 of pop over 1 of window 1
      click radio button "OK" of radio group 1 of UI element 1 of row 1 of table 1 of scroll area 1 of pop over 1 of window 1
      delay 1
    end tell
  end repeat
end run
