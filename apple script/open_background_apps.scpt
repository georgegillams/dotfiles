#!/usr/bin/osascript
on run argv
  if application "Dato" is not running then
    tell application "Dato" to activate
  end if

  if application "Raycast" is not running then
    tell application "Raycast" to activate
  end if
end run