# Copy firefox chrome.css to profile directories:
open /Applications/Firefox\ Developer\ Edition.app/
sleep 10
cd /Users/georgegillams/Library/Application\ Support/Firefox/Profiles/
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}' && cp -R ~/Documents/georgegillams/dotfiles/chrome ./" \;
cd -
sleep 10
pkill firefox
