curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
source ~/.zshrc
nvm install node
nvm alias default node
nvm use default
sudo chown -R $USER:$GROUP ~/.npm
sudo chown -R $USER:$GROUP ~/.config

echo "Update the path in \`.zshrc\` to make a default version of Node available without using \`nvm\`"
echo "Press any key once complete"
read