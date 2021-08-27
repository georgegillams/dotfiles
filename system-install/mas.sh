echo "Sign in to the AppStore. Press enter when complete"
open '/System/Applications/App Store.app'
read

sudo chown -R $(whoami) /usr/local/lib/pkgconfig

mas install 1444383602 # GoodNotes 5
mas install 1043270657 # GIF Keyboard
mas install 1176895641 # Spark Email
mas install 1278508951 # Trello
mas install 409183694 # Keynote
mas install 409201541 # Pages
mas install 409203825 # Numbers
mas install 585829637 # Todoist
mas install 937984704 # Amphetamine
# mas install 497799835 # XCode 
