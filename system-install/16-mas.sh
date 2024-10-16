
echo "Sign in to the AppStore. Press enter when complete"
open '/System/Applications/App Store.app'
read

setup_type=$(cat ~/Desktop/setup_type.txt)

sudo chown -R $(whoami) /usr/local/lib/pkgconfig

mas install 937984704 # Amphetamine
# mas install 1254981365 # Contrast — Color Accessibility
# mas install 2125818515 # Contraster
mas install 1444383602 # GoodNotes 6
mas install 409183694 # Keynote
mas install 409203825 # Numbers
mas install 409201541 # Pages
mas install 1593408455 # Anybox
mas install 1891057991 # Folder Preview
# mas install 1524540481 # Widgy Widgets

if [[ $setup_type == "WORK" ]]; then
  mas install 1470584107 # Dato
fi