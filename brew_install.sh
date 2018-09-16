/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

brew update
brew tap caskroom/cask
brew tap caskroom/fonts && brew cask install font-source-code-pro
brew tap caskroom/versions && brew cask install java8
brew tap wix/brew

brew cask install adobe-creative-cloud
brew cask install alfred
brew cask install android-studio
brew cask install atom
brew cask install authy
brew cask install avibrazil-rdm
brew cask install bettertouchtool
brew cask install caffeine
brew cask install canary
brew cask install caret
brew cask install charles
brew cask install cleanmymac
brew cask install detexify
brew cask install docker
brew cask install dropbox
brew cask install firefox
brew cask install firefox-developer-edition
brew cask install franz
brew cask install gifox
brew cask install google-chrome
brew cask install handbrake
brew cask install imageoptim
brew cask install insomnia
brew cask install iterm2
brew cask install nordvpn
brew cask install postman
brew cask install postman
brew cask install rocket
brew cask install sketch
brew cask install slack
brew cask install slack
brew cask install sourcetree
brew cask install spotify
brew cask install the-unarchiver
brew cask install vanilla
brew cask install vectr
brew cask install virtualbox
brew cask install vlc
brew install ack
brew install applesimutils # detox
brew install cmake
brew install coffeescript
brew install cowsay
brew install docker
brew install docker-compose
brew install git
brew install heroku/brew/heroku
brew install imagemagick
brew install imageoptim-cli
brew install libdvdcss
brew install lolcat
brew install lynx
brew install macvim
brew install mas
brew install node@8
brew install python3
brew install rbenv
brew install redis
brew install sl
brew install the_silver_searcher
brew install vim
brew install watchman
brew install wget
brew install zsh zsh-completions

mas install 926036361 # LastPass
mas install 1031163338 # GIFHunter
mas install 585829637 # Todoist
mas install 937984704 # Amphetamine
mas install 1404231964 # UPRIGHT GO
mas install 661676740 # iGif Creator
mas install 909566003 # iHex - Hex Editor

# install NVM and RVM
\curl -sSL https://get.rvm.io | bash -s stable
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

# Set up Git SSH
ssh-keygen -t rsa -b 4096 -C "george.gillams@skyscanner.net"
echo "Now go to Github, select Add SSH key and paste the public file contents"
pbcopy < ~/.ssh/id_rsa.pub
sleep 10
echo "Press any key once complete"
read

npm login

cd ~/Documents && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cd ~/Documents && git clone https://github.com/georgegillams/dotfiles.git
cp dotfiles/.vimrc ~/.vimrc && cp dotfiles/.zshrc ~/.zshrc
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

# Install YCM backend:
ln -s /usr/local/bin/mvim ~/vim
ln -s /usr/local/bin/mvim ~/vi
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer

# Clone common guithub repos
cd ~/Documents && git clone git@github.com:georgegillams/georgegillams.co.uk.git
cd ~/Documents && git clone git@github.com:georgegillams/georgegillams_ssr_2.git
cd ~/Documents && git clone git@github.com:georgegillams/dotfiles.git
backpack-setup && georgegillams-setup && georgegillams-ssr-2 && npm i

# Copy firefox chrome.css to profile directories:
# open /Applications/Firefox\ Developer\ Edition.app/
# open /Applications/Firefox.app/
# sleep 10
# cd /Users/georgegillams/Library/Application\ Support/Firefox/Profiles/
# find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}' && cp -R ~/Documents/dotfiles/chrome ./" \;
# cd -
# sleep 10
# pkill firefox

# Run Lastpass installer
open /usr/local/Caskroom/adobe-creative-cloud/latest/Creative\ Cloud\ Installer.app
open /usr/local/Caskroom/lastpass/latest/LastPass\ Installer.app
open /Applications/Docker.app/
open /Applications/Firefox\ Developer\ Edition.app/
open /Applications/Firefox.app/
open /Applications/Utilities/Adobe\ Creative\ Cloud/ACC/Creative\ Cloud.app/
open /Applications/Alfred\ 3.app/
open /Applications/Dropbox.app
open /Applications/Authy\ Desktop.app/
open /Applications/Canary.app/
open /Applications/NordVPN.app/
open /Applications/Todoist.app/
open /Applications/Spotify.app/
open ./resources/Network\ Link\ Conditioner.prefPane

echo "NOW INSTALL MANUALLY ☹️"
echo "Logitech gaming software => http://support.logitech.com/en_gb/software/lgs"
cd ~/Downloads && wget https://download01.logi.com/web/ftp/pub/techsupport/gaming/LogitechSetup_8.98.306.zip && open LogitechSetup_8.98.306.zip && sleep 30 && open LogitechGamingInstaller.app
echo "Node version"
cd ~/Downloads && wget https://nodejs.org/download/release/v8.12.0/node-v8.12.0.pkg && sudo installer -store -pkg "./node-v8.12.0.pkg" -target /
echo "Secure password character extractor => https://www.georgegillams.co.uk/apps/password-character-extractor"
cd ~/Downloads && wget https://raw.githubusercontent.com/georgegillams/SecurePasswordCharacterExtractor/master/release/Secure_Password_Character_Extractor.zip && open Secure_Password_Character_Extractor.zip && sleep 10 && mv Secure\ Password\ Character\ Extractor.app/ /Applications/
echo "Nord theme for iTerm => https://github.com/arcticicestudio/nord-iterm2"
open https://github.com/arcticicestudio/nord-iterm2
sleep 10
echo "Press any key once complete"
read

# Do this last as it's huge!
mas install 497799835 # XCode

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

