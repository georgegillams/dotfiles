. ./00-setup-type.sh

# Export PDF option
sudo mkdir -p /Library/Filters/
sudo cp ../resources/Reduce\ File\ Size\ a\ Bit.qfilter /Library/Filters/

# Enable press-and-hold typing in VSCode and cursor
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
defaults write com.todesktop.230313mzl4w4u92 ApplePressAndHoldEnabled -bool false

# Add heic to jpg workflow
# open ../resources/HEIC\ to\ JPG.workflow

# Sign in to apps
# echo "Sign in to NPM"
# echo "npm login"
# npm login

echo "NOW INSTALL MANUALLY ☹️"

if [[ $setup_type == "PERSONAL_SETUP_PROFILE_1" ]]; then
  echo "EOS Utility => https://www.canon.co.uk/support/consumer_products/software/eos-utility.html"
# open /usr/local/Caskroom/canon-eos-utility/*/*.app
fi

if [[ $setup_type == "PERSONAL_SETUP_PROFILE_1" ]]; then
  echo "DaVinci Resolve => https://www.blackmagicdesign.com/products/davinciresolve"
  open "https://www.blackmagicdesign.com/products/davinciresolve"
fi


if [[ $setup_type == "PERSONAL_SETUP_PROFILE_1" ]]; then
  echo "Sigma Optimization => https://www.sigma-global.com/en/support/software/sigma-optimization-pro/?os=mac"
fi

echo "Nord theme for iTerm => https://github.com/arcticicestudio/nord-iterm2"
open ../resources/
echo "Open iTerm preferences, select profiles, colours and import the NORD theme. Also select font Fira Mono for Powerline, size 12, under Text"
echo "ALTERNATIVELY, LOAD SETTINGS FROM CLOUD FILE"
echo "Press enter when complete"
read

echo "Chorder => https://github.com/georgegillams/chorder#download"
open "https://github.com/georgegillams/chorder#download"
echo "Press any key once complete"
read

if [[ $setup_type == "PERSONAL_SETUP_PROFILE_1" ]]; then
  echo "Obs Studio => https://obsproject.com/download"
  echo "Obs studio move plugin => https://obsproject.com/forum/resources/move.913/"

  echo "Obsbot => https://www.obsbot.com/download/"
  open https://www.obsbot.com/download/
fi

if [[ $setup_type == "WORK_SETUP_PROFILE_TF" ]]; then
  echo "Install Claude code"
  echo "Press any key once complete"
  read
  rtk init -g
fi

# Set default apps for file types
# Hint: to find the app id use:
# osascript -e 'id of app "APP_NAME_HERE"'
# Webstorm: com.jetbrains.webstorm
# Cursor: com.todesktop.230313mzl4w4u92
# VSCode: com.microsoft.VSCode
if [ -d "/Applications/Cursor.app" ]; then
  editorAppId="com.todesktop.230313mzl4w4u92"
else
  editorAppId="com.microsoft.VSCode"
fi

../set-default-app.sh org.videolan.vlc m4a
../set-default-app.sh org.videolan.vlc mp3
../set-default-app.sh org.videolan.vlc aac
../set-default-app.sh org.videolan.vlc wav
../set-default-app.sh $editorAppId css
../set-default-app.sh $editorAppId scss
../set-default-app.sh $editorAppId sh
../set-default-app.sh $editorAppId zsh
../set-default-app.sh $editorAppId js
../set-default-app.sh $editorAppId ts
../set-default-app.sh $editorAppId jsx
../set-default-app.sh $editorAppId tsx
../set-default-app.sh $editorAppId md
../set-default-app.sh $editorAppId mdx
../set-default-app.sh $editorAppId txt
../set-default-app.sh $editorAppId json
../set-default-app.sh $editorAppId toml
../set-default-app.sh $editorAppId nix
../set-default-app.sh $editorAppId rs
