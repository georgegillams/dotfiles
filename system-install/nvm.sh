# Setup default nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

echo "Ensure you do anything that brew has asked following installation"
echo "Press enter when complete"
read

nvm install node
nvm alias default node
nvm use default
sudo chown -R $USER:$GROUP ~/.npm
sudo chown -R $USER:$GROUP ~/.config
