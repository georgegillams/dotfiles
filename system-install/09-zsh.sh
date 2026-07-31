brew install --cask microsoft-excel

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Add iterm zsh integration
curl -L https://iterm2.com/shell_integration/zsh \
-o ~/.iterm2_shell_integration.zsh

# Install powerline fonts:
installDir=$(pwd)
cd ~/Documents/
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts
cd $installDir

# Copy zsh config
cp -R ../.zsh ~/
cp ../.zshrc ~/

if [[ $setup_type == "WORK_SETUP_PROFILE_TF" ]]; then
  echo "Copy typeform.zsh file from Google Drive to ~/.zsh/"
  open ~/.zsh/
  echo "Press enter when complete"
  read
fi

# Download zsh plugins
mkdir -p ~/.oh-my-zsh/custom
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k