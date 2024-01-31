# cp ../.gitconfig ~/.gitconfig
sudo cp ../gpg-agent.conf ~/.gnupg/gpg-agent.conf

# # Set up Krypt.co SSH/GPG keys:
# echo "Enter dev mode in the app to get started"
# echo "Remember to add the new keys to all GitHub instances"
# curl https://krypt.co/kr | sh
# kr pair
# kr github
# read
# kr codesign
# read

echo "Sign in to GitHub.com"
open https://github.com/login
echo "Press any key once complete"
read

# Set up Git SSH
ssh-agent
ssh-keygen -t rsa -b 4096 -C "code@georgegillams.co.uk"
echo "Now go to Github, select Add SSH key and paste the public file contents"
pbcopy < ~/.ssh/id_rsa.pub
open https://github.com/settings/keys
sleep 10
echo "Press any key once complete"
read
ssh-add ~/.ssh/id_rsa

# Prevent system needing SSH password all the time
echo "Host *\n  UseKeychain yes" > ~/.ssh/config

# Set up Git commit signing
echo "Open GPG Keychain and configure a new GPG key for Git signing"
open /Applications/GPG\ Keychain.app/
echo "Press enter when complete"
read
gpg --list-secret-keys --keyid-format LONG
echo "Please copy the sec key ID (shorter string after /) from the Git GPG key and enter it"
read keyId
echo "Please copy the sec key (long string) from the Git GPG key and enter it"
read keyLong
git config --global user.signingkey $keyId
git config --global commit.gpgSign true
git config --global user.name "George Gillams"
git config --global user.email code@georgegillams.co.uk
echo "Now go to Github, select New GPG key and paste the exported data"
gpg --export -a $keyLong | pbcopy
sleep 10
echo "Press any key once complete"
read

# setup `git diff-image`
# installDir=$(pwd)
# cd ~/Documents
# git clone git@github.com:ewanmellor/git-diff-image.git
# cd git-diff-image
# ./install.sh
# cd ..
# rm -rf git-diff-image
# cd $installDir

echo "Sign in to GH CLI - public"
echo "gh auth login"
gh auth login