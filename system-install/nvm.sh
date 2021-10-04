# Setup default nvm
nvm install lts/erbium
nvm alias default lts/erbium
nvm use default
sudo chown -R $USER:$GROUP ~/.npm
sudo chown -R $USER:$GROUP ~/.config
