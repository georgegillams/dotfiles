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

  if application "BetterTouchTool" is not running then
    tell application "BetterTouchTool" to activate
  end if

  if application "Stream Deck" is not running then
    tell application "Stream Deck" to activate
  end if

end run