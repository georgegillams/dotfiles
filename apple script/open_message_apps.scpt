#!/usr/bin/osascript
on run argv
  tell app "System Events" to display dialog "It's time to check your messages! 📮" with title "💬 Message check time!" buttons {"Not now", "OK"} default button 1
  if button returned of result is "Not now" then
    return
  end if

  # open Slack
  if application "Slack" is not running then
    tell application "Slack" to activate
  end if
  
  # Outlook
  if application "Microsoft Outlook" is not running then
    tell application "Microsoft Outlook" to activate
  end if

  # open Gmail
  # tell application "Gmail" to activate
  
  # open Gmail Typeform
  # tell application "/Users/george.gillams/Applications/Gmail Typeform.app" to activate

  # open WhatsApp
  # tell application "WhatsApp" to activate

  # open Messages
  # tell application "Messages" to activate
end run