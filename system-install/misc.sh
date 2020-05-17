echo "Expose 1Password entries to Alfred. Hit enter when complete."
read

# Export PDF option
sudo mkdir /Library/Filters/
sudo cp dotfiles/resources/Reduce\ File\ Size\ a\ Bit.qfilter /Library/Filters/

# Sign in to apps
npm login
pod trunk register george.gillams@skyscanner.net
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

echo "Nord theme for iTerm => https://github.com/arcticicestudio/nord-iterm2"
cd ~/Downloads && wget https://raw.githubusercontent.com/arcticicestudio/nord-iterm2/develop/src/xml/Nord.itermcolors
open https://github.com/arcticicestudio/nord-iterm2
echo "Open iTerm preferences, select profiles, colours and import the NORD theme. Also select Powerline font under Text"
read
rm -rf Nord.itermcolors

echo "Snap camera"
open https://snapcamera.snapchat.com/download/
sleep 10
echo "Press any key once complete"
read
