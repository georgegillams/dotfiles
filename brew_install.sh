/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

echo "Enable iTerm touchID"
echo "Paste this into /etc/pam.d/sudo"
echo "auth sufficient pam_tid.so" | pbcopy
sudo vim /etc/pam.d/sudo

brew update
brew tap caskroom/cask
brew tap caskroom/fonts && brew cask install font-source-code-pro
brew tap caskroom/versions && brew cask install java8
brew tap wix/brew

# needed to make mas install work
sudo chown -R $(whoami) /usr/local/lib/pkgconfig

brew cask install adobe-creative-cloud
brew cask install alfred
brew cask install android-platform-tools
brew cask install android-studio
brew cask install atom
brew cask install authy
brew cask install avibrazil-rdm
brew cask install caret
brew cask install charles
brew cask install coconutbattery
brew cask install colour-contrast-analyser
brew cask install dash
brew cask install docker
brew cask install dropbox
brew cask install franz
brew cask install gifox
brew cask install google-chrome
brew cask install handbrake
brew cask install homebrew/cask-versions/firefox-developer-edition
brew cask install imageoptim
brew cask install iterm2
brew cask install muzzle
brew cask install nordvpn
brew cask install oracle-jdk
brew cask install pock
brew cask install postman
brew cask install qbittorrent
brew cask install reflector
brew cask install sketch
brew cask install slack
brew cask install soundflower
brew cask install sourcetree
brew cask install spotify
brew cask install the-unarchiver
# brew cask install virtualbox
# brew cask install virtualbox-extension-pack
brew cask install parallels
brew cask install vlc
brew install ack # CLI search
brew install applesimutils # detox
brew install clang-format
brew install cloc # count lines of code
brew install cmake
brew install cowsay
brew install docker
brew install docker-compose
brew cask install homebrew/cask-drivers/canon-eos-utility
brew install exiftool
brew install git
brew install golang
brew install gpg
brew install htop
brew install hub
brew install imagemagick
brew install imageoptim-cli
brew install libdvdcss
brew install lolcat
brew install lynx
brew install macvim
brew install mas # CLI apps store
brew install mitmproxy
brew install nvm
brew install python3
brew install rbenv
brew install redis
brew install sl
brew install swiftlint
brew install the_silver_searcher
brew install tree
brew install vim
brew install w3m
brew install watchman
brew install wget
brew install yarn
brew install zsh zsh-completions

# Add iterm zsh integration
curl -L https://iterm2.com/shell_integration/zsh \
-o ~/.iterm2_shell_integration.zsh

echo "Sign in to the AppStore. Press enter when complete"
open /Applications/App\ Store.app
read

mas install 1031163338 # GIFHunter
mas install 1039705526 # Grabbie
mas install 1278508951 # Trello
mas install 409183694 # Keynote
mas install 409201541 # Pages
mas install 409203825 # Numbers
mas install 447521961 # XChat Azure
mas install 552792489 # Status Clock
mas install 585829637 # Todoist
mas install 693112260 # Sim Daltonism
mas install 909566003 # iHex - Hex Editor
mas install 926036361 # LastPass Password Manager
mas install 937984704 # Amphetamine
mas install 957734279 # Toggl
mas install 961632517 # Be Focused Pro - Focus Timer
mas install 980577198 # Tunacan - Image concatenator

echo "Sign in to LastPass. Hit enter when complete."
open /Applications/LastPass.app
read

# Setup default nvm
nvm install 10.13.0
nvm use 10.13.0
sudo chown -R $USER:$GROUP ~/.npm
sudo chown -R $USER:$GROUP ~/.config

# install NVM and RVM
\curl -sSL https://get.rvm.io | bash -s stable

git config --global user.name "George Gillams" && git config --global user.email george.gillams@skyscanner.net

# Set up Krypt.co SSH/GPG keys:
echo "Enter dev mode in the app to get started"
echo "Remember to add the new keys to all GitHub instances"
curl https://krypt.co/kr | sh
kr pair
kr github
read
kr codesign
read

# # Set up Git SSH
# ssh-keygen -t rsa -b 4096 -C "george.gillams@skyscanner.net"
# echo "Now go to Github, select Add SSH key and paste the public file contents"
# pbcopy < ~/.ssh/id_rsa.pub
# sleep 10
# echo "Press any key once complete"
# read

# # Set up Git commit signing
# gpg --gen-key
# echo "Configuring git to use the new GPG key"
# gpg --list-secret-keys --keyid-format LONG
# echo "Please copy the sec key and enter it"
# read keyLong
# git config --global user.signingkey $(keyLong)
# git config --global commit.gpgSign true
# echo "Now go to Github, select New GPG key and paste the exported data"
# gpg --export -a $(keyLong) | pbcopy
# sleep 10
# echo "Press any key once complete"
# read

echo "Logging in to NPM"
npm login

pod trunk register george.gillams@skyscanner.net

cd ~/Documents && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cd ~/Documents && git clone https://github.com/georgegillams/dotfiles.git
cp dotfiles/.vimrc ~/.vimrc
cp dotfiles/.zshrc ~/.zshrc
cp dotfiles/.tmux.conf ~/.tmux.conf
. ~/.zshrc
vim +"source ~/.vimrc" +PluginInstall +qall
defaults write com.apple.finder AppleShowAllFiles YES

# Install powerline fonts:
cd ~/Documents/
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# setup `git diff-image`
cd ~/Documents
git clone git@github.com:ewanmellor/git-diff-image.git
cd git-diff-image
./install.sh
cd ..
rm -rf git-diff-image

# Install YCM backend:
ln -s /usr/local/bin/mvim ~/vim
ln -s /usr/local/bin/mvim ~/vi
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer

# Clone common guithub repos
cd ~/Documents && rm -rf dotfiles
cd ~/Documents && git clone git@github.com:georgegillams/dotfiles.git
cd dotfiles && npm i
cd ~/Documents && git clone git@github.com:georgegillams/georgegillams.co.uk.git
cd ~/Documents && git clone git@github.com:Skyscanner/backpack.git
cd ~/Documents && git clone git@github.com:Skyscanner/backpack-ios.git
cd ~/Documents && git clone git@github.com:Skyscanner/backpack-android.git
cd ~/Documents && git clone git@github.com:Skyscanner/backpack-react-native.git
backpack-setup && backpack-ios-setup && georgegillams-setup && backpack-rn-setup

# Copy firefox chrome.css to profile directories:
open /Applications/Firefox\ Developer\ Edition.app/
open /Applications/Firefox.app/
sleep 10
cd /Users/georgegillams/Library/Application\ Support/Firefox/Profiles/
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}' && cp -R ~/Documents/dotfiles/chrome ./" \;
cd -
sleep 10
pkill firefox

# Run Lastpass installer
open /usr/local/Caskroom/adobe-creative-cloud/latest/Creative\ Cloud\ Installer.app
open /Applications/Docker.app/
open /Applications/Firefox\ Developer\ Edition.app/
open /Applications/Firefox.app/
open /Applications/Utilities/Adobe\ Creative\ Cloud/ACC/Creative\ Cloud.app/
open /Applications/Alfred\ 3.app/
open /Applications/Dropbox.app
open /Applications/Authy\ Desktop.app/
open /Applications/NordVPN.app/
open /Applications/Todoist.app/
open /Applications/Spotify.app/
open ./resources/Network\ Link\ Conditioner.prefPane

echo "NOW INSTALL MANUALLY ☹️"
# echo "Logitech gaming software => http://support.logitech.com/en_gb/software/lgs"
# cd ~/Downloads && wget https://download01.logi.com/web/ftp/pub/techsupport/gaming/LogitechSetup_8.98.306.zip && open LogitechSetup_8.98.306.zip && sleep 30 && open LogitechGamingInstaller.app
# echo "Node version"
# cd ~/Downloads && wget https://nodejs.org/download/release/v8.12.0/node-v8.12.0.pkg && sudo installer -store -pkg "./node-v8.12.0.pkg" -target /
echo "Secure password character extractor => https://www.georgegillams.co.uk/apps/password-character-extractor"
cd ~/Downloads && wget https://raw.githubusercontent.com/georgegillams/SecurePasswordCharacterExtractor/master/release/Secure_Password_Character_Extractor.zip && open Secure_Password_Character_Extractor.zip && sleep 10 && mv Secure\ Password\ Character\ Extractor.app/ /Applications/
rm -rf Secure_Password_Character_Extractor.zip

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

# Do this last as it's huge!
mas install 497799835 # XCode

# # setup XCode plugins
# cd ~/Documents
# git clone git@github.com:travisjeffery/ClangFormat-Xcode.git
# cd ~/Documents/ClangFormat-Xcode && open ClangFormat.xcodeproj
# sudo gem install update_xcode_plugins
# update_xcode_plugins

# Setup backpack ios dependencies:
open /Applications/Xcode.app/
echo "Wait until Xcode installation completes, and then press a key to continue"
read
cd ~/Documents/backpack && rbenv install $(cat native/ios/.ruby-version)
sudo gem install bundler

# Setup backpack android dependencies:
open /Applications/Android\ Studio.app/
echo "Wait until Android Studio installation completes, and then press a key to continue"
read
read
read
read
read
$HOME/Library/Android/sdk/tools/bin/sdkmanager --licenses
$HOME/Library/Android/sdk/tools/bin/sdkmanager "system-images;android-27;google_apis;x86"
$HOME/Library/Android/sdk/tools/bin/sdkmanager "system-images;android-21;google_apis;x86"
$HOME/Library/Android/sdk/tools/bin/avdmanager create avd --name "bpk-avd" --package "system-images;android-27;google_apis;x86" --device "pixel" && cp native/android/bpk-avd.ini ~/.android/avd/bpk-avd.avd/config.ini
$HOME/Library/Android/sdk/tools/bin/avdmanager create avd --name "bpk-avd-min" --package "system-images;android-21;google_apis;x86" --device "Nexus 5"
