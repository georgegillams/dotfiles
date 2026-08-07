. ./00-setup-type.sh

# Add iterm zsh integration
# curl -L https://iterm2.com/shell_integration/zsh \
# -o ~/.iterm2_shell_integration.zsh

# Install powerline fonts:
installDir=$(pwd)
cd ~/Documents/
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
echo "CHECK INSTALL SCRIPT IS SECURE - READ/EDIT IT BEFORE RUNNING!"
read
./install.sh
cd ..
rm -rf fonts
cd $installDir

# Copy zsh entrypoint file
cp ../.zshrc ~/

if [[ $setup_type == "WORK_SETUP_PROFILE_HS" ]]; then
  echo "ADD HS_DRIVE export to ~/.zshrc"
  echo "Press enter when complete"
  read
fi
