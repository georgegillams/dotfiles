setup_type=$(cat ~/Desktop/setup_type.txt)

if [[ $setup_type == "WORK" ]]; then
  brew install --cask blender
  mas install 497799835 # XCode
fi