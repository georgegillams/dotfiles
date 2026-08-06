. ./00-setup-type.sh

echo "Sign in to the AppStore. Press enter when complete"
open '/System/Applications/App Store.app'
read

if [[ $setup_type == "WORK_SETUP_PROFILE_HS" ]]; then
  echo "Install Microsoft To Do\nPress any key when done"
  read
fi

if [[ $setup_type == "PERSONAL_SETUP_PROFILE_1" ]]; then
sudo chown -R $(whoami) /usr/local/lib/pkgconfig
fi

if [[ $setup_type == "WORK_SETUP_PROFILE_TF" ]]; then
  mas install 1470584107 # Dato
fi

if [[ $setup_type == "PERSONAL_SETUP_PROFILE_1" ]]; then
  # mas install 1524540481 # Widgy Widgets
  mas install 409183694 # Keynote
  mas install 409201541 # Pages
  mas install 409203825 # Numbers
  mas install 6464116077 # Contraster
  mas install 1444383602 # GoodNotes 6
  mas install 1593408455 # Anybox
  mas install 1891057991 # Folder Preview
  mas install 6450280202 # Day Progress
  mas install 6754022187 # Menu Drop
  mas install 937984704 # Amphetamine
fi