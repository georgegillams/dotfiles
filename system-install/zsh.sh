sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

# Add iterm zsh integration
curl -L https://iterm2.com/shell_integration/zsh \
-o ~/.iterm2_shell_integration.zsh

# Install powerline fonts:
cd ~/Documents/
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

cp -R dotfiles/.zsh /Users/georgegillams/
cp dotfiles/.zshrc ~/.zshrc
. ~/.zshrc

mkdir -p ~/.warp/themes
cp -R dotfiles/warp-themes/* ~/.warp/themes/