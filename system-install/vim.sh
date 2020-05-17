cd ~/Documents && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
mkdir ~/Documents/georgegillams
cd ~/Documents/georgegillams && git clone https://github.com/georgegillams/dotfiles.git
cp dotfiles/.vimrc ~/.vimrc
cp dotfiles/.zshrc ~/.zshrc
cp dotfiles/.tmux.conf ~/.tmux.conf
. ~/.zshrc
vim +"source ~/.vimrc" +PluginInstall +qall
defaults write com.apple.finder AppleShowAllFiles YES

# Install YCM backend:
ln -s /usr/local/bin/mvim ~/vim
ln -s /usr/local/bin/mvim ~/vi
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
