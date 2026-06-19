. ~/Documents/georgegillams/dotfiles/system-install/00-setup-type.sh

if [[ $setup_type == "WORK_SETUP_PROFILE_1" ]]; then
  brew install --cask blender
  mas install 497799835 # XCode
fi