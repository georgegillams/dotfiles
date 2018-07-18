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
brew cask install dropbox
brew cask install firefox
brew cask install firefox-developer-edition
brew cask install franz
brew cask install gifox
brew cask install google-chrome
brew cask install imageoptim
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
brew install applesimutils # detox
brew install cmake
brew install coffeescript
brew install cowsay
brew install docker
brew install docker-compose
brew install git
brew install heroku/brew/heroku
brew install imageoptim-cli
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
brew install watchman
brew install wget
brew install zsh zsh-completions

mas install 497799835 # XCode
mas install 926036361 # LastPass
mas install 1031163338 # GIFHunter
mas install 585829637 # Todoist
mas install 937984704 # Amphetamine

# Set up Git SSH
ssh-keygen -t rsa -b 4096 -C "george.gillams@skyscanner.net"
echo "Now go to Github, select Add SSH key and paste the public file contents"
pbcopy < ~/.ssh/id_rsa.pub
sleep 10
echo "Press any key once complete"
read

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
ln -s /usr/local/bin/mvim vim
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer

# Clone common guithub repos
cd ~/Documents && git clone https://github.com/georgegillams/georgegillams.co.uk.git
cd ~/Documents && git clone https://github.com/georgegillams/georgegillams_ssr_2.git
cd ~/Documents && git clone https://github.com/skyscanner/backpack.git
backpack-setup && georgegillams-setup && georgegillams-ssr-2 && npm i

# Run Lastpass installer
open /usr/local/Caskroom/lastpass/latest/LastPass\ Installer.app

# Copy iterm2 initial settings over
sudo cp iterm_dropbox_sync_config ~/Library/Preferences/com.googlecode.iterm2.plist

echo "NOW INSTALL MANUALLY ☹️"
open http://support.logitech.com/en_gb/software/lgs
open https://github.com/arcticicestudio/nord-iterm2
sleep 10
echo "Press any key once complete"
read
