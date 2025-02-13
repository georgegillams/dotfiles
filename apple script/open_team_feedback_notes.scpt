#!/usr/bin/osascript
on run argv
  tell app "System Events" to display dialog "It's time to make some feedback notes! 📝" with title "📝 Feedback notes time!" buttons {"Not now", "OK"} default button 1
  if button returned of result is "Not now" then
    return
  end if

  do shell script "open -a 'WebStorm' ~/Google\\ Drive/My\\ Drive/2_Areas/Work/Typeform/Performance/Feedback/2025\\ Q3/Given"
end run
