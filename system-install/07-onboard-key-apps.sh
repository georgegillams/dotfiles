#!/bin/bash
. ~/Documents/georgegillams/dotfiles/system-install/00-setup-type.sh

if [[ $setup_type == "PERSONAL_SETUP_PROFILE_1" ]]; then
  open /Applications/1Password.app
  open /Applications/Google\ Drive.app
fi