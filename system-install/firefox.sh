Copy firefox chrome.css to profile directories:
open /Applications/Firefox\ Developer\ Edition.app/
echo "SIGN IN"
echo "Open Firefox about:config and enable toolkit.legacyUserProfileCustomizations.stylesheets"
echo "Set gfx.webrender.all=true"
echo "Set layout.css.backdrop-filter.enabled=true"
echo "NOW CLOSE FIREFOX"
echo "Press any key once complete"
read
cd /Users/george.gillams/Library/Application\ Support/Firefox/Profiles/
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}' && cp -R ~/Documents/georgegillams/dotfiles/chrome ./" \;
cd -
