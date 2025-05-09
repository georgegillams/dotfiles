# ========================== SYSTEM ==========================

alias whence-function='echo "use declare -f FUNC"'

alias duplicate-tab='open . -a iterm'

alias system-wifi-off='networksetup -setairportpower Wi-Fi off'
alias system-wifi-on='networksetup -setairportpower Wi-Fi on'
alias system-wifi-reboot='run-raycast-script reset-wifi'
function zsh-remove-term-from-history() { cat ~/.zsh_history | grep -v $@ > ~/.zsh_history_updated && sleep 2 && cp ~/.zsh_history_updated ~/.zsh_history && rm ~/.zsh_history_updated && echo "Quit iTerm to finish the job\!" }
alias zsh-rebuild='(dotfiles-save-zshrc || true) && source ~/.zshrc'
alias zsh-pull='(dotfiles-pull-zshrc || true) && source ~/.zshrc'
alias tmux-rebuild='dotfiles-save-tmux-conf && cd - && tmux source-file ~/.tmux.conf'
alias vim-rebuild='vim +"source ~/.vimrc" +PluginInstall +qall && dotfiles-save-vimrc && cd -'
alias zsh-edit-config='open-code-editor ~/.zsh && open-code-editor ~/.zshrc'
alias tmux-edit-config='vim ~/.tmux.conf'
alias documents='cd-if-necessary ~/Documents'
alias desktop='cd-if-necessary ~/Desktop'
alias gradle-clear-cache='rm -rf $HOME/.gradle/caches/'
alias system-clear-caches='run-concurrently -n run-docker,empty-cache,docker-reset "open /Applications/Docker.app" "rm -rf /Users/george.gillams/Library/Caches" "sleep 60 && (zsh -ci docker-reset-prune)"'
alias system-delete-message-attachements='rm -rf /Users/george.gillams/Library/Messages/Attachments/*'
alias system-delete-ios-backups='rm -rf /Users/george.gillams/Library/Application\ Support/MobileSync/Backup/*'
alias system-clean='open ~/Desktop && open ~/Downloads && open ~/Documents && open /Applications && system-clear-caches && system-delete-message-attachements && system-delete-ios-backups'
alias system-clear-adobe-caches='rm -rf /Users/george.gillams/Library/Caches/Adobe'
alias system-read-mail='open-code-editor /var/mail/george.gillams'

alias cron-edit='crontab -e'
alias cron-save='dotfiles-save-cron'

alias in-this-photo='(dotfiles && osascript ./apple\ script/copyITP.scpt ~/Documents/georgegillams/dotfiles/resources/in_this_photo.jpg)'
alias inthisphoto='in-this-photo'

alias calendar-acknowledge-calendar-notifications='(dotfiles && osascript ./apple\ script/acknowledge\ calendar\ notifications.scpt)'

alias nvm-fix-erbium-npm-version='nvm use 13.0.0 && nvm uninstall lts/erbium && nvm install lts/erbium && nvm alias default lts/erbium'

alias weather-southampton='curl wttr.in/Southampton'
alias weather-portsmouth='curl wttr.in/Portsmouth'
alias weather-london='curl wttr.in/London'
alias weather-barcelona='curl wttr.in/Barcelona'
alias weather='weather-southampton';

function launch-zoom-meeting() {
  open https://typeform.zoom.us/j/$1
}

function run-concurrently() {
    if [ ! -x "$(which concurrently)" ]; then
      echo "concurrently is not available, installing..."
      yarn global add concurrently
    fi;
    concurrently -c "auto" $@
}

alias vim-edit-config='open-code-editor ~/.vimrc'

alias kill-process='sudo kill -9'
function list-processes-on-port() { sudo lsof -i :$@ }
function list-process-pids-on-port() { list-processes-on-port $@ | grep -v PID | awk '{print $2}' }
function kill-processes-on-port() { for pid in $(list-process-pids-on-port $@); do kill-process $pid; done }

function system-sigterm-first-matching-process() {
  kill -SIGTERM $(pgrep -i $@ | head -n 1)
}

alias system-flush-dns-cache="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias system-sleep="pmset sleepnow"
alias system-clear-asl="sudo rm -rf /private/var/log/asl/*.asl"
alias system-clean-desktop="mv ~/Desktop/* ~/.Trash/ && mv ~/.Trash/season_ticket* ~/Desktop/"
alias system-fix-quick-previews="pkill QuickLookUIService"
alias system-fix-audio="sudo killall coreaudiod & sudo kill -9 `ps ax|grep 'coreaudio[a-z]' | awk '{print $1}'`"
alias system-fix-sound="system-fix-audio"
alias system-fix-touch-id="(dotfiles && cd system-install && . ./04-touch_id.sh)"
alias system-fix-finder-lagging="mv ~/Library/Preferences/com.apple.finder.plist ~/Desktop/ && echo \"NOW RESTART. IF EVERYTHING IS FINE, DELETE ~/Desktop/com.apple.finder.plist\""
alias system-fix-vimrc-location="mkdir -p ~/.config/vim && echo 'source ~/.vimrc' > ~/.config/vim/init.vim"
alias system-open-ms-updater="open /Library/Application\ Support/Microsoft/MAU2.0/Microsoft\ AutoUpdate.app"
alias system-open-cc-updater="open /Applications/Adobe\ Creative\ Cloud/Adobe\ Creative\ Cloud"
alias system-update-brew-apps="brew update && brew outdated && brew upgrade && brew outdated --cask && brew upgrade --cask"
alias system-open-topaz='if [[ -d /Applications/Topaz\ Photo\ AI.app ]]; then open /Applications/Topaz\ Photo\ AI.app; fi'
alias system-update-apps='run-concurrently -n brew,mas,manual "zsh -ci system-update-brew-apps" "mas outdated && mas upgrade" && system-open-cc-updater && zsh -ci system-open-topaz'
alias system-fix-spotlight='sudo mdutil -E'
alias system-fix-ssh='ssh-add -K ~/.ssh/id_rsa &>/dev/null && echo "Host *\n    UseKeychain yes" > ~/.ssh/config'
alias system-fix-gpg='(gpg-agent --daemon || true) && gpg-agent --default-cache-ttl 2592000 && gpg -s ~/.zshrc && rm ~/.zshrc.gpg'
alias system-disable-spotlight='mv /System/Library/LaunchAgents/com.apple.Spotlight.plist /System/Library/LaunchAgents/com.apple.Spotlight.plist.BAK && mv /System/Library/LaunchDaemons/com.apple.metadata.mds.plist /System/Library/LaunchDaemons/com.apple.metadata.mds.plist.BAK'
alias system-disable-indexing='sudo mdutil -a -i off'
alias system-show-hidden-files='defaults write com.apple.finder AppleShowAllFiles YES'
alias system-fix-rvm-openssl='brew reinstall openssl --ignore-dependencies && brew upgrade ruby-build rbenv'
alias web-browser='w3m'
alias system-fix-dyld='brew update && brew upgrade && brew link --overwrite ruby && brew reinstall ruby vim'

alias system-dark-mode='osascript -e "tell application \"System Events\" to tell appearance preferences to set dark mode to true"'
alias system-light-mode='osascript -e "tell application \"System Events\" to tell appearance preferences to set dark mode to false"'

alias system-dock-hide-forever='defaults write com.apple.dock autohide-delay -float 1000; killall Dock'
alias system-dock-make-stickier='defaults write com.apple.dock autohide-delay -float 5.0; killall Dock'
alias system-dock-move-back='system-dock-restore-defaults && sleep 1 && system-dock-make-stickier'
alias system-dock-restore-defaults='defaults delete com.apple.dock autohide-delay; killall Dock'

alias system-backup-macbook='echo "BEFORE RUNNING THIS, ENSURE SECRETS ARE REMOVED FROM ZSH_HISTORY.\nPRESS ANY KEY IF THIS IS ALREADY DONE" && read && open "$MY_PERSONAL_DRIVE/2_Areas/Apps" && cp ~/.zsh_history "$MY_PERSONAL_DRIVE/2_Areas/Apps/" && echo "Save a screenshot of the dock + menubar\nBackup raycast settings\nBackup widgets"'

alias tmux-create-session='tmux new -s'
alias tmux-attach-session='tmux attach -t'
alias tmux-detach="tmux detach"
alias tmux-detatch="tmux-detach"
alias tmux-split="tmux split-window"
alias tmux-split-vertical="tmux-split"
alias tmux-split-horizontal="tmux split-window -h"
alias tmux-close="tmux kill-pane"
alias tmux-exit="tmux-close"

alias android-shake='$ANDROID_SDK_ROOT/platform-tools/adb shell input keyevent 82'
alias android-shake-twice='android-shake && sleep 3 && android-shake'

alias arrange-displays-RL='displayplacer "id:37D8832A-2D66-02CA-B9F7-8F30A301B230 res:1800x1169 hz:120 color_depth:8 enabled:true scaling:on origin:(0,0) degree:0" "id:E3C934F6-761F-469E-8F24-5486082F3F6D res:2560x1440 hz:60 color_depth:8 enabled:true scaling:off origin:(940,-1440) degree:0" "id:C8F0D9FB-2989-409F-9ABF-7AA6411F26B2 res:2560x1440 hz:60 color_depth:8 enabled:true scaling:off origin:(-1620,-1440) degree:0"'
alias arrange-displays-XREAL='displayplacer "id:37D8832A-2D66-02CA-B9F7-8F30A301B230 res:1800x1169 hz:120 color_depth:8 enabled:true scaling:on origin:(0,0) degree:0" "id:38E4C915-26AD-4F65-B1CB-2D438803227E res:1920x1080 hz:120 color_depth:8 enabled:true scaling:on origin:(-59,-1080) degree:0"'

function arrange-displays () {
  hdmiMonitorPresent=$(displayplacer list | grep "Persistent screen id: 5768F6DE-C603-B581-0857-D6964E3302DB" | cut -d\, -f1)
  xrealAirPresent=$(displayplacer list | grep "Persistent screen id: 38E4C915-26AD-4F65-B1CB-2D438803227E" | cut -d\, -f1)

  if [ -n "$hdmiMonitorPresent" ]; then
    echo "Arranging RL displays at desk"
    arrange-displays-RL
  elif [ -n "$xrealAirPresent" ]; then
    echo "Arranging virtual displays"
    arrange-displays-XREAL
  fi
}

function edit-raycast-script() {
  open-code-editor ~/Documents/georgegillams/dotfiles/raycast/scripts/$1.sh
}

function run-raycast-script() {
  . ~/Documents/georgegillams/dotfiles/raycast/scripts/$1.sh $2 $3
}

function run-raycast-script-drive() {
  # . $MY_TF_DRIVE/raycast/scripts/$1.sh $2 $3
  . $MY_PERSONAL_DRIVE/2_Areas/Apps/raycast/scripts/$1.sh $2 $3
}

alias quit-immersed='osascript -e "quit app \"Immersed\""'
alias quit-meta-workspaces='osascript -e "quit app \"Meta Quest Remote Desktop\""'
alias dim-macbook-screen='(dotfiles && osascript ./apple\ script/decrease\ brightness.scpt)'
alias brighten-macbook-screen='(dotfiles && osascript ./apple\ script/increase\ brightness.scpt)'

alias immersed='open /Applications/Immersed.app'
alias immersed-end='quit-immersed && brighten-macbook-screen && arrange-displays'
alias workspaces='open /Applications/Meta\ Quest\ Remote\ Desktop.app && dim-macbook-screen'
alias workspaces-end='quit-meta-workspaces && brighten-macbook-screen && arrange-displays'
alias xreal='arrange-displays && open /Applications/Nebula\ for\ Mac.app/ && sleep 10 && dim-macbook-screen'
alias xreal-end='pkill Nebula\ for\ Mac && brighten-macbook-screen && arrange-displays'

alias airpods='run-raycast-script airpods-only'
alias mic-and-airpods='run-raycast-script mic-and-airpods'

function merge-pdfs () {
  first_arg=$1
  shift 1 # Shifts the input arguments 1 place to the left to give all args except the first
  gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile="$first_arg" $@
}
