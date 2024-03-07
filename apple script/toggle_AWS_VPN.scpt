#!/usr/bin/osascript
on run argv
  tell application "AWS VPN Client" to reopen

  tell application "System Events" to tell process "AWS VPN Client"
  	repeat until (exists window "AWS VPN Client")
  		delay 0.1
  	end repeat
  
  	-- store Connect/Disconnect button title, it'll help us later
  	set btnLabel to name of button 1 of window "AWS VPN Client"
  
  	-- hide the window as early as possible
  	set visible to false
  
  	-- connect or disconnect
  	click button 1 of window "AWS VPN Client"
  
  	-- close the window
  	click button 2 of window "AWS VPN Client"
  
  	-- now's the tricky part:
  	if btnLabel is "Connect" then
  		-- if we're connecting,
  		-- we need to wait for the window to appear the second time
  		-- (triple_facepalm.webp here) 
  		-- and close it again
  
  		-- wait for the windows to appear
  		repeat until (exists window "AWS VPN Client")
  			delay 0.01
  		end repeat
  
  		-- hide the window as early as possible
  		set visible to false
  
  		-- close the window
  		click button 2 of window "AWS VPN Client"
  	else
  		-- if we're disconnecting, then
  		-- wait for some time and quit the client
  		delay 2
  		tell application "AWS VPN Client" to quit
  	end if
  end tell
end run