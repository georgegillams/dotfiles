cp ../.gitconfig ~/.gitconfig

# # Set up Krypt.co SSH/GPG keys:
# echo "Enter dev mode in the app to get started"
# echo "Remember to add the new keys to all GitHub instances"
# curl https://krypt.co/kr | sh
# kr pair
# kr github
# read
# kr codesign
# read

# Set up Git SSH
ssh-keygen -t rsa -b 4096 -C "george.gillams@skyscanner.net"
echo "Now go to Github, select Add SSH key and paste the public file contents"
pbcopy < ~/.ssh/id_rsa.pub
sleep 10
echo "Press any key once complete"
read

# Set up Git commit signing
gpg --gen-key
echo "Configuring git to use the new GPG key"
gpg --list-secret-keys --keyid-format LONG
echo "Please copy the sec key and enter it"
read keyLong
git config --global user.signingkey $(keyLong)
git config --global commit.gpgSign true
echo "Now go to Github, select New GPG key and paste the exported data"
gpg --export -a $(keyLong) | pbcopy
sleep 10
echo "Press any key once complete"
read

# setup `git diff-image`
cd ~/Documents
git clone git@github.com:ewanmellor/git-diff-image.git
cd git-diff-image
./install.sh
cd ..
rm -rf git-diff-image
