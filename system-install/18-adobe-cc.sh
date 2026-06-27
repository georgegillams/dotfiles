. ~/Documents/georgegillams/dotfiles/system-install/00-setup-type.sh

if [[ $setup_type == "PERSONAL_SETUP_PROFILE_1" ]]; then
  brew install --cask adobe-creative-cloud
  open /usr/local/Caskroom/adobe-creative-cloud/latest/Creative\ Cloud\ Installer.app
  open /Applications/Utilities/Adobe\ Creative\ Cloud/ACC/Creative\ Cloud.app/
fi
