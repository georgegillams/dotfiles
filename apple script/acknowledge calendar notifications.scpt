on run argv
  tell application "/System/Applications/Calendar.app" to activate
  tell application "System Events" to tell process "Calendar"
      # Select inbox:
      if value of radio button 2 of radio group 1 of group 1 of toolbar 1 of window 1 is not 1 then
        click radio button 2 of radio group 1 of group 1 of toolbar 1 of window 1
      end if
      
      # Select New
      click radio button "New" of radio group 1 of scroll area 1 of splitter group 1 of splitter group 1 of window 1

      # Acknowledge all
      repeat while button "OK" of UI element 1 of row 1 of table 1 of scroll area 1 of scroll area 1 of splitter group 1 of splitter group 1 of window 1 exists
        click button "OK" of UI element 1 of row 1 of table 1 of scroll area 1 of scroll area 1 of splitter group 1 of splitter group 1 of window 1
        delay 0.2
      end repeat
  end tell
end run
