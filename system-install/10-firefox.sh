# Copy firefox chrome.css to profile directories:
open /Applications/Firefox\ Developer\ Edition.app/
echo "Sign in"
echo "Open about:config and turn off browser.gesture.swipe.left, browser.gesture.swipe.right, and browser.urlbar.trimURLs"
echo "Then close Firefox"
echo "Press any key once complete"
read

cd /Users/george.gillams/Library/Application\ Support/Firefox/Profiles/
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}' && cp -R ~/Documents/georgegillams/dotfiles/chrome ./" \;
cd -

echo "\nSet Firefox as the default browser"
open "x-apple.systempreferences:com.apple.Desktop-Settings.extension"
echo "Press any key once complete"
read
