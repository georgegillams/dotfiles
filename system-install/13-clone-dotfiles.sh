. ./00-setup-type.sh

# Re-clone dotfiles, this time as a git repo using ssh
echo "ENSURE YOU RUN THIS IN A NEW TAB SO THAT ALIASES ARE LOADED"
echo "Press any key if ready to continue"
read
dotfiles
cd ..
rm -rf dotfiles
dotfiles
yarn
