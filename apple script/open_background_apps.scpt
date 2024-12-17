#!/usr/bin/osascript
on run argv
  if application "Dato" is not running then
    tell application "Dato" to activate
  end if

  if application "Raycast" is not running then
    tell application "Raycast" to activate
  end if

  if application "Anybox" is not running then
    tell application "Anybox" to activate
    tell application "Anybox" to set miniaturized of windows to true
  end if
end run