/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
brew tap caskroom/fonts && brew cask install font-source-code-pro
brew install zsh zsh-completions
brew cask install adobe-creative-cloud
brew cask install alfred
brew cask install atom
brew install the_silver_searcher
brew cask install authy
brew cask install gifox
brew cask install avibrazil-rdm
brew cask install bettertouchtool
brew cask install canary
brew install rbenv
brew install cmake
brew cask install caret
brew cask install charles
brew cask install cleanmymac
brew cask install dropbox
brew cask install spotify
brew cask install virtualbox
brew cask install firefox
brew cask install firefox-developer-edition
brew cask install franz
brew cask install google-chrome
brew cask install iterm2
brew cask install nordvpn
brew cask install postman
brew cask install rocket
brew cask install slack
brew cask install slack
brew cask install sourcetree
brew cask install the-unarchiver
brew cask install vanilla
brew cask install imageoptim
brew cask install sketch
brew install imageoptim-cli
brew install sl
brew cask install vlc
brew install heroku/brew/heroku
brew install python3
brew install redis
brew install wget
brew install watchman
brew tap caskroom/versions && brew cask install java8
brew cask install android-studio
cd ~/Documents && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cd ~/Documents && git clone https://github.com/georgegillams/dotfiles.git
cp dotfiles/.vimrc ~/.vimrc && cp dotfiles/.zshrc ~/.zshrc
. ~/.zshrc
vim +"source ~/.vimrc" +PluginInstall +qall
defaults write com.apple.finder AppleShowAllFiles YES
open https://github.com/arcticicestudio/nord-iterm2

# Install detox
brew tap wix/brew
brew install applesimutils

# Install powerline fonts:
cd ~/Documents/
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# Install YCM backend:
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer

echo "Now install manually:\nAmphetamine\nLastpass\nGifHunter\nTodoist"
