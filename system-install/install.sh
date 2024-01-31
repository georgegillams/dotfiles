#!/bin/bash

(. ./01-software-update.sh)
(. ./02-system-preferences.sh)
(. ./03-finder.sh)
(. ./04-touch_id.sh)
(. ./05-brew.sh)
(. ./06-cldt.sh)

# SWITCH TO ITERM
# LOAD SETTINGS FROM FILE, DON'T OVERWRITE
# RESTART ITERM
# CHANGE TO SAVE SETTINGS ON QUIT

(. ./07-onboard-key-apps.sh)
(. ./08-zsh.sh)
(. ./09-firefox.sh)
(. ./10-git.sh)
(. ./11-nvm.sh)

# OPEN A NEW TAB
# CHECK THAT ZSH IS LOADING PROPERLY

(. ./12-clone-dotfiles.sh)
(. ./13-rbenv.sh)
(. ./14-vim.sh)
(. ./15-mas.sh)
(. ./16-misc.sh)
(. ./17-adobe-cc.sh)
(. ./18-large-downloads.sh)
(bash ./19-onboard-all-apps.sh)
(. ./20-login-items-and-permissions.sh)
