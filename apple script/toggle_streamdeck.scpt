#!/usr/bin/osascript
on run argv
  -- Check if laptop is plugged into power
  set powerSource to do shell script "pmset -g batt | grep -o 'AC Power\\|Battery Power' | head -1"
  
  if powerSource is "AC Power" then
    -- Laptop is plugged in, run Stream Deck app
    try
      tell application "Stream Deck" to activate
      -- If app is not running, launch it
      if not (application "Stream Deck" is running) then
        tell application "Stream Deck" to launch
      end if
    on error
      -- If Stream Deck is not found, try to launch it anyway
      do shell script "open -a 'Stream Deck'"
    end try
  else
    -- Laptop is not plugged in, kill Stream Deck app
    try
      tell application "Stream Deck" to quit
    on error
      -- If Stream Deck is not running, do nothing
    end try
  end if
end run
