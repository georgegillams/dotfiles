# Export PDF option
sudo mkdir -p /Library/Filters/
sudo cp ../resources/Reduce\ File\ Size\ a\ Bit.qfilter /Library/Filters/

# Enable press-and-hold typing in VSCode
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

# Add heic to jpg workflow
# open ../resources/HEIC\ to\ JPG.workflow

# Sign in to apps
# echo "Sign in to NPM"
# echo "npm login"
# npm login

# echo "NOW INSTALL MANUALLY ☹️"
# echo "EOS Utility => https://www.canon.co.uk/support/consumer_products/software/eos-utility.html"
# open /usr/local/Caskroom/canon-eos-utility/*/*.app

echo "Nord theme for iTerm => https://github.com/arcticicestudio/nord-iterm2"
cd ~/Downloads && wget https://raw.githubusercontent.com/arcticicestudio/nord-iterm2/develop/src/xml/Nord.itermcolors
open https://github.com/arcticicestudio/nord-iterm2
echo "Open iTerm preferences, select profiles, colours and import the NORD theme. Also select font Source Code Pro, size 12, under Text"
echo "Press enter when complete"
read
rm -rf Nord.itermcolors

# echo "Obs Studio => https://obsproject.com/download"
# open https://obsproject.com/download
# open https://obsproject.com/forum/resources/move.913/

echo "Obsbot => https://www.obsbot.com/download/"
open https://www.obsbot.com/download/
