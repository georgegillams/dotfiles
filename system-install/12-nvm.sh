curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
source ~/.zshrc
nvm install node
nvm alias default node
nvm use default
sudo chown -R $USER:$GROUP ~/.npm
sudo chown -R $USER:$GROUP ~/.config

echo "Now open a new tab, and install some version of node to use as a default.\neg \`nvm install 20\`"
echo "Press any key once complete"
read