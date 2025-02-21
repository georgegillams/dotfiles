#!/usr/bin/osascript
on run argv
  tell app "System Events" to display dialog "It's time to make some feedback notes! 📝" with title "📝 Feedback notes time!" buttons {"Not now", "OK"} default button 1
  if button returned of result is "Not now" then
    return
  end if

  do shell script "/Users/george.gillams/Library/CloudStorage/GoogleDrive-hello@georgegillams.co.uk/My\\ Drive/2_Areas/Apps/raycast/scripts/feedback.sh"
end run
