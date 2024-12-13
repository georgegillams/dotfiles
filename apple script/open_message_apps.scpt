#!/usr/bin/osascript
on run argv
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