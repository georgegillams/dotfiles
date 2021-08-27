# echo "Expose 1Password entries to Alfred. Hit enter when complete."
# read

# Export PDF option
sudo mkdir -p /Library/Filters/
sudo cp ../resources/Reduce\ File\ Size\ a\ Bit.qfilter /Library/Filters/

# Add heic to jpg workflow
open ../resources/HEIC\ to\ JPG.workflow

# Sign in to apps
echo "Sign in to NPM"
echo "npm login"
npm login

echo "Sign in to GH CLI - public"
echo "gh auth login"
gh auth login

echo "Sign in to GH CLI - enterprise"
echo "gh auth login"
gh auth login

open /usr/local/Caskroom/adobe-creative-cloud/latest/Creative\ Cloud\ Installer.app
open /Applications/Docker.app/
open /Applications/Firefox\ Developer\ Edition.app/
open /Applications/Utilities/Adobe\ Creative\ Cloud/ACC/Creative\ Cloud.app/
open /Applications/Alfred\ 3.app/
open /Applications/Dropbox.app
open /Applications/NordVPN.app/
open /Applications/Todoist.app/
open /Applications/1Password\ 7.app
open ./resources/Network\ Link\ Conditioner.prefPane

echo "NOW INSTALL MANUALLY ☹️"
echo "EOS Utility => https://www.canon.co.uk/support/consumer_products/software/eos-utility.html"
open /usr/local/Caskroom/canon-eos-utility/*/*.app

echo "Clean My Mac X => https://cleanmymac.com"
open https://macpaw.com/download/cleanmymac

# echo "Aerial Screensaver => https://aerialscreensaver.github.io"
# open https://github.com/glouel/AerialCompanion/releases/latest/download/AerialInstaller.dmg

echo "Nord theme for iTerm => https://github.com/arcticicestudio/nord-iterm2"
cd ~/Downloads && wget https://raw.githubusercontent.com/arcticicestudio/nord-iterm2/develop/src/xml/Nord.itermcolors
open https://github.com/arcticicestudio/nord-iterm2
echo "Open iTerm preferences, select profiles, colours and import the NORD theme. Also select Powerline font under Text"
read
rm -rf Nord.itermcolors

# echo "Snap camera"
# open https://snapcamera.snapchat.com/download/
# sleep 10
# echo "Press any key once complete"
# read
