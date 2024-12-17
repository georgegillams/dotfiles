#!/usr/bin/osascript
on run argv
  display notification "It's time to check your messages. 📮 Message apps will open imminently!" with title "💬 Message check time!"

  delay 3

  # open Slack
  tell application "Slack" to activate
  
  # open Gmail
  tell application "Gmail" to activate
  
  # open Gmail Typeform
  tell application "Gmail Typeform" to activate

  # open WhatsApp
  tell application "WhatsApp" to activate

  # open Messages
  tell application "Messages" to activate
end run