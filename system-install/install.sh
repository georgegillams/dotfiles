#!/bin/bash

(. ./01-software-update.sh)
(. ./02-system-preferences.sh)
(. ./03-finder.sh)
(. ./04-touch_id.sh)
(. ./05-brew.sh)
(. ./06-cldt.sh)
(. ./07-onboard-key-apps.sh)
(. ./08-install-safari-apps.sh)

# SWITCH TO ITERM
# LOAD SETTINGS FROM FILE, DON'T OVERWRITE
# RESTART ITERM
# CHANGE TO SAVE SETTINGS ON QUIT

(. ./09-zsh.sh)
(. ./10-firefox.sh)
(. ./11-git.sh)
(. ./12-nvm.sh)

# OPEN A NEW TAB
# CHECK THAT ZSH IS LOADING PROPERLY

(. ./13-clone-dotfiles.sh)
(. ./14-rbenv.sh)
(. ./15-vim.sh)
(. ./16-mas.sh)
(. ./17-misc.sh)
(. ./18-adobe-cc.sh)
(. ./19-large-downloads.sh)
(bash ./19-onboard-all-apps.sh)
(. ./21-login-items-and-permissions.sh)
