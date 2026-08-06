#!/usr/bin/osascript
on run argv
  if application "Raycast" is not running then
    tell application "Raycast" to activate
  end if

  # if application "Stream Deck" is not running then
  #   tell application "Stream Deck" to activate
  # end if

end run
