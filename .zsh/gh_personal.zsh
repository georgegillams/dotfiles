# ==================== PERSONAL PROJECTS =====================
export MY_PERSONAL_DRIVE="/Users/george.gillams/Library/CloudStorage/GoogleDrive-hello@georgegillams.co.uk/My Drive"

alias 1p-personal='op signin --account my.1password.com'

alias daily-backup="ge-backup && hrp-backup && netmon-backup && cursor-backup"

alias gg-aws='clone-and-cd georgegillams aws'

alias on-this-day='open "https://www.timeanddate.com/on-this-day/$(date +%B| tr "[:upper:]" "[:lower:]")/$(date +%e | xargs)"'

alias sort-phone-photos='clone-and-cd georgegillams image-meta-fixer && [[ -d node_modules ]] || yarn && yarn action "$MY_PERSONAL_DRIVE/2_Areas/Photography/Camera Uploads/" "$MY_PERSONAL_DRIVE/2_Areas/Photography/iPhone photos" --fix --move'

alias dotfiles='clone-and-cd georgegillams dotfiles'
alias dotfiles-nuke='cd ~/Documents/georgegillams/ && sudo rm -rf dotfiles && git clone git@github.com:georgegillams/dotfiles.git'
alias dotfiles-save-tmux-conf='dotfiles && cp ~/.tmux.conf ./ && gaa && gcmpchore "Update TMUX conf"'
# alias dotfiles-save-zshrc='dotfiles && cp ~/.zshrc ./ && cp ~/.zsh/gh_* ./.zsh/ && cp ~/.zsh/typeform.zsh $MY_TF_DRIVE/.zsh/typeform.zsh && gd && sleep 2 && gaa && gcmpchore "Update ZSHRC"'
alias dotfiles-pull-zshrc='dotfiles && gml && cp .zshrc ~/ && cp .zsh/* ~/.zsh/'
function dotfiles-save-zshrc() {
  dotfiles
  cp ~/.zshrc ./
  cp ~/.zsh/gh_* ./.zsh/
  if [[ -f ~/.zsh/typeform.zsh ]]; then
    cp ~/.zsh/typeform.zsh $MY_PERSONAL_DRIVE/2_Areas/Work/Typeform/.zsh/typeform.zsh
  fi
  gd
  sleep 2
  gaa
  gcmpchore "Update ZSHRC"
}
alias dotfiles-save-launchd='dotfiles && cp /Library/LaunchDaemons/uk.co.georgergillams.* ./resources/Launch/LaunchDaemons && cp /Users/george.gillams/Library/LaunchAgents/uk.co.georgergillams.* ./resources/Launch/LaunchAgents/ && gd && sleep 2 && gaa && gcmpchore "Update launchd"'
alias dotfiles-save-cron='dotfiles && crontab -l > ./resources/crontab && sleep 2 && gaa && gcmpchore "Update crontab"'
alias dotfiles-save-vimrc='dotfiles && cp ~/.vimrc ./ && gaa && gcmpchore "Update VIMRC"'
alias dotfiles-edit-install-script='(dotfiles && cd system-install && c)'
alias brew-edit-install-script='dotfiles-edit-install-script'
alias dotfiles-commit-brew-script='dotfiles && gaa && gcmpchore "Update brew install script"'
alias dotfiles-save-vscode-settings='dotfiles && cp ~/Library/Application\ Support/Code/User/*.json ./vscode/ && gaa && gcmpchore "Update vscode settings"'

alias browser-scripts='clone-and-cd georgegillams browser-scripts'
alias browser-scriptss='browser-scripts && yarn setup'
alias browser-scripts-commit='browser-scripts && browser-scripts-build-readme && gaa && gcmpfeat "Update scripts"'
alias browser-scripts-nuke='cd ~/Documents/georgegillams/ && sudo rm -rf browser-scripts && git clone git@github.com:georgegillams/browser-scripts.git'
alias browser-scripts-build-readme='browser-scripts && yarn build:readme'
alias browser-scripts-extension='browser-scripts && cd src/Notion\ Sidebar\ Expander/'
alias browser-scripts-extensiono='browser-scripts-extension && npx web-ext run --firefox=/Applications/Firefox\ Developer\ Edition.app/Contents/MacOS/firefox-bin'

alias bt='clone-and-cd georgegillams backpack-transpiled'
alias bt-nuke='cd ~/Documents/georgegillams/ && sudo rm -rf backpack-transpiled && git clone git@github.com:georgegillams/backpack-transpiled.git'
alias bts='bt && yarn install'
alias bt-fix-permissions='sudo chown -R $(whoami) ./'
alias bt-pull-backpack='yarn pull-backpack:clean && git clone https://github.com/Skyscanner/backpack.git && yarn pull-backpack:changelog && (cd backpack && yarn install && yarn build && (find packages -name "node_modules" -exec rm -rf {} \; || true))'
alias bt-ship='bts && bt-fix-permissions && bt-pull-backpack && yellow "Ready to release, Please run $(blue "yarn release:TYPE")"'

alias r2d2-ssh-ec2='ssh ubuntu@ec2-35-178-235-11.eu-west-2.compute.amazonaws.com'
alias zendog-ssh-ec2='ssh ubuntu@ec2-13-40-134-151.eu-west-2.compute.amazonaws.com'

alias tgi='clone-and-cd georgegillams tg-intervals'
alias tgis='tgi'
alias tgio='tgi && make dev'

alias gwa='clone-and-cd georgegillams webapp-boilerplate'
alias gwa-nuke='cd ~/Documents/georgegillams/ && sudo rm -rf webapp-boilerplate && git clone git@github.com:georgegillams/webapp-boilerplate.git'
alias gwa-start-transpile-watch-in-new-tab="osascript -e 'tell application \"iTerm\" to activate' -e 'tell application \"System Events\" to tell process \"iTerm\" to keystroke \"t\" using command down' -e 'tell application \"System Events\" to tell process \"iTerm\" to keystroke \"gwa && yarn gg-webapp-transpile:watch\"' -e 'tell application \"System Events\" to tell process \"iTerm\" to key code 52'"
alias gwa-start='gwa && gwa-start-transpile-watch-in-new-tab && console-ninja yarn dev'
alias gwas='gwa && PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true yarn gg-webapp-install && PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true yarn install && yarn prebuild'
alias gwa-live-build='gwa && yarn gg-webapp-transpile && yarn gg-webapp-transpile:live'
alias gwao='gwa && console-ninja yarn dev'
alias gwa-deploy='gwa && yarn build && zip -r build build && scp -o "StrictHostKeyChecking=no" -r ./build.zip ubuntu@www.georgegillams.co.uk:/home/ubuntu/webapp-boilerplate/'
alias gwa-docker-build-image='gwa && docker build -t webapp-boilerplate-test -f Dockerfile.backstopjstest .'
alias gwa-update-snapshots='gwa && ./scripts/docker/prepare.sh && ./scripts/docker/run-tests.sh --update --tty && ./scripts/docker/clean-up.sh'
alias gwa-update-snapshots-skip-npm='gwa && ./scripts/docker/prepare.sh && ./scripts/docker/run-tests.sh --update --tty --skip-npm && ./scripts/docker/clean-up.sh'
alias gwa-link-live-to-this-project='yellow "Ensure you are already running gwa-live-build alongside this app" && (gwa && cd gg-webapp/dist && yarn link) && yarn link @george-gillams/webapp'
alias gwa-fix-all='gwa && run-concurrently -n test,lint,browserlist "yarn test:update" "yarn lint" "zsh -ci npx-update-browserlist-db"'

alias cl='clone-and-cd georgegillams contentful-links'
alias cls='cl && echo "No setup required"'
alias clo='cl && console-ninja yarn dev'
alias clbuild='cl && yarn build'

alias cardc='clone-and-cd georgegillams card-challenge'
alias cardc-nuke='cd ~/Documents/georgegillams/ && sudo rm -rf card-challenge && git clone git@github.com:georgegillams/card-challenge.git'
alias cardcs='cardc && PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true yarn install && yarn prebuild'
alias cardc-deploy='cardc && yarn build && zip -r build build && scp -o "StrictHostKeyChecking=no" -r ./build.zip ubuntu@www.georgegillams.co.uk:/home/ubuntu/card-challenge/'

alias ge='clone-and-cd georgegillams georgegillams.co.uk'
alias ge-nuke='cd ~/Documents/georgegillams/ && sudo rm -rf georgegillams.co.uk && git clone git@github.com:georgegillams/georgegillams.co.uk.git'
alias ges='ge && PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true yarn install && yarn prebuild'
alias geo='ge && console-ninja yarn dev'
alias ge-backup='ge && 1p-personal && node scripts/backup-production-data.js --apiKey $(op item get "AWS Private REST API Key" --vault Personal --field password --reveal --cache) --backupsLocation "$MY_PERSONAL_DRIVE/1_Projects/georgegillams.co.uk/backups"'
alias ge-deploy='ge && yarn build && zip -r build build && scp -o "StrictHostKeyChecking=no" -r ./build.zip ubuntu@www.georgegillams.co.uk:/home/ubuntu/georgegillams.co.uk/'
alias ge-update-snapshots='ge && ./scripts/docker/prepare.sh && ./scripts/docker/run-tests.sh --update --tty && ./scripts/docker/clean-up.sh'
alias ge-update-snapshots-skip-npm='ge && ./scripts/docker/prepare.sh && ./scripts/docker/run-tests.sh --update --tty --skip-npm && ./scripts/docker/clean-up.sh'
alias ge-fix-all='ge && run-concurrently -n test,lint,browserlist "yarn test -u" "yarn lint" "zsh -ci npx-update-browserlist-db"'

alias ihh='clone-and-cd georgegillams isithappyhour.net'
alias ihhs='ihh && PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true yarn install && yarn prebuild'
alias ihho='ihh && console-ninja yarn dev'
alias ihh-fix-all='ihh && run-concurrently -n test,lint,browserlist "yarn test -u" "yarn lint" "zsh -ci npx-update-browserlist-db"'

alias hrp='clone-and-cd georgegillams hyroxrelayplanner.com'
alias hrps='hrp && PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true yarn install && yarn prebuild'
alias hrpo='hrp && console-ninja yarn dev'
alias hrp-fix-all='hrp && run-concurrently -n test,lint,browserlist "yarn test -u" "yarn lint" "zsh -ci npx-update-browserlist-db"'
alias hrp-backup='hrp && 1p-personal && node scripts/backup-production-data.js --apiKey $(op item get "AWS Private REST API Key" --vault Personal --field password --reveal --cache) --backupsLocation "$MY_PERSONAL_DRIVE/1_Projects/Hyrox Relay Planner/backups"'

alias ggc='clone-and-cd georgegillams components'
alias ggc-nuke='cd ~/Documents/georgegillams/ && sudo rm -rf components && git clone git@github.com:georgegillams/components.git'
alias ggcs='ggc && PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true yarn'
alias ggco='ggc && console-ninja yarn dev'
alias ggc-update-snapshots='ggc && ./scripts/docker/snapshot-test/prepare.sh && ./scripts/docker/snapshot-test/run-tests.sh --update --tty && ./scripts/docker/snapshot-test/clean-up.sh'
alias ggc-live-build='ggc && yarn transpile && yarn transpile:js:live'
alias ggc-link-live-to-this-project='yellow "Ensure you are already running ggc-live-build alongside this app" && (cd node_modules/react && yarn link) && (cd node_modules/react-dom && yarn link) && (ggc && yarn link react && yarn link react-dom && cd dist && yarn link) && yarn link @george-gillams/components'
alias ggc-fix-all='ggc && run-concurrently -n test,lint,browserlist "yarn test -u" "yarn lint:fix" "zsh -ci npx-update-browserlist-db"'

alias sra='clone-and-cd georgegillams screen-reader-adventures'
alias sra-nuke='cd ~/Documents/georgegillams/ && sudo rm -rf screen-reader-adventures && git clone git@github.com:georgegillams/screen-reader-adventures.git'
alias sras='sra && PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true yarn install'
alias sra-update-snapshots='sra && ./scripts/docker/prepare.sh && ./scripts/docker/run-tests.sh --update --tty && ./scripts/docker/clean-up.sh'
alias sra-update-snapshots-skip-npm='sra && ./scripts/docker/prepare.sh && ./scripts/docker/run-tests.sh --update --tty --skip-npm && ./scripts/docker/clean-up.sh'

alias contraster='clone-and-cd georgegillams contraster'
alias contrasters='contraster && echo "No setup required"'
alias contrastero='contraster && open Contraster.xcodeproj'

alias meg='clone-and-cd georgegillams my-event-guide'
alias megs='meg && echo "No setup required"'
alias mego='meg && open MyEventGuide.xcodeproj'

alias boiler='clone-and-cd georgegillams boiler-server'
alias boilers='boiler && yarn'
alias boilero='boiler && (sleep 1 && open http://localhost:8080/logs) & console-ninja yarn start'
alias boiler-deploy='boiler && rsync -avr -e "ssh -l pi" --exclude ".git" --exclude "node_modules" ./* pi@192.168.1.96:/home/pi/Documents/georgegillams/boiler-server'
alias boiler-backup='curl http://192.168.1.96:3000/logs-raw > "$MY_PERSONAL_DRIVE/2_Areas/Boiler hot water issue/Boiler restart logs/$(date).txt"'

alias ant='clone-and-cd georgegillams ant-ics'
alias ants='ant && yarn'
alias anto='ant && (sleep 1 && open http://localhost:8080/logs) & console-ninja yarn start'
alias ant-deploy='ant && rsync -avr -e "ssh -l pi" --exclude ".git" --exclude "node_modules" ./* pi@192.168.0.98:/home/pi/Documents/georgegillams/ant-ics'

alias netmon='clone-and-cd georgegillams network-monitor'
alias netmons='netmon && yarn'
alias netmono='netmon && (sleep 1 && open http://localhost:8080/logs) & console-ninja yarn start'
alias netmon-deploy='netmon && rsync -avr -e "ssh -l pi" --exclude ".git" --exclude "node_modules" ./* pi@192.168.1.96:/home/pi/Documents/georgegillams/network-monitor'
alias netmon-backup='curl http://192.168.1.96:3001/logs-raw > "$MY_PERSONAL_DRIVE/2_Areas/Network/Network logs/$(date).txt" && curl http://192.168.1.96:3001/ips > "$MY_PERSONAL_DRIVE/2_Areas/Network/Network logs/$(date)-ips.txt"'

alias sck='clone-and-cd georgegillams software-chording-keyboard'
alias scks='sck'
alias scko='sck && open Software\ Chording\ Keyboard.xcodeproj'

alias dsc='clone-and-cd georgegillams ai-hero-deepsearch-course && cd ./courses/01-deepsearch-in-typescript/00-apps/01-day-1-app'
alias dscs='dsc && yarn'
alias dsco='./start-database.sh && ./start-redis.sh && yarn dev'

alias goals-and-dreams='run-raycast-script goals'

alias ethernet-disconnect='system-disable-usb-lan'
alias ethernet-reconnect='system-enable-usb-lan'

# ========================== PHOTOGRAPHY ==========================

function repeat-until-success() {
  local max_tries=24
  local try=1
  while [ $try -le $max_tries ]; do
    if eval "$@"; then
      break
    else
      sleep 5
    fi
  done
}

function eject-SD-card() {
  if [[ -d /Volumes/$@ ]]; then
    repeat-until-success "diskutil eject $@"
  fi
}

function try-eject-SD-cards() {
  eject-SD-card "EOS_DIGITAL"
  eject-SD-card "DJI_DIGITAL"
  eject-SD-card "SD_Card"
  eject-SD-card "disk4s1"
}

function copy-images-from-SD-given-directory() {
  if [[ -d $@ ]]; then
    open "$MY_PERSONAL_DRIVE/2_Areas/Photography/Pictures/import/"
    mkdir -p $@/GOT
    echo "Copying photos..."
    find $@ -type f -maxdepth 1 -execdir cp "{}" "$MY_PERSONAL_DRIVE/2_Areas/Photography/Pictures/import/" ";"
    echo "Move copied files to GOT..."
    find $@ -type f -maxdepth 1 -execdir mv "{}" $@/GOT/ ";"
    open $@/
    echo "Press any key when done"
    read
    echo "Ejecting card..."
    try-eject-SD-cards
  fi
}

function copy-SD-card-images() {
  copy-images-from-SD-given-directory "/Volumes/EOS_DIGITAL/DCIM/100EOS_R"
  copy-images-from-SD-given-directory "/Volumes/EOS_DIGITAL/DCIM/101EOS_R"
  copy-images-from-SD-given-directory "/Volumes/DJI_DIGITAL/DCIM/100MEDIA"
  copy-images-from-SD-given-directory "/Volumes/DJI_DIGITAL/DCIM/101MEDIA"
  copy-images-from-SD-given-directory "/Volumes/SD_Card/DCIM/DJI_001"
  copy-images-from-SD-given-directory "/Volumes/Untitled/Movies"
}

function cursor-backup() {
  . ~/Documents/georgegillams/dotfiles/system-install/00-setup-type.sh
  if [[ $setup_type == "WORK" ]]; then
    rsync -av --exclude='History' ~/Library/Application\ Support/Cursor/User/* $MY_PERSONAL_DRIVE/2_Areas/Apps/Cursor/User/ && cursor --list-extensions > $MY_PERSONAL_DRIVE/2_Areas/Apps/Cursor/extensions.txt
  fi
}

function vimex() {
    local temp_file=$(mktemp)
    vim "$temp_file"
    if [ -s "$temp_file" ]; then # Check if the file is not empty
        chmod +x "$temp_file" # Make it executable
        "$temp_file"
    else
        echo "No content to execute."
    fi
    rm "$temp_file"
}

function cursorex() {
    local temp_file=$(mktemp)
    cursor "$temp_file"
    # Wait for changes to file
    fswatch -o "$temp_file" | while read; do
      if [ -s "$temp_file" ]; then # Check if the file is not empty
          chmod +x "$temp_file" # Make it executable
          "$temp_file"
          break
      else
          echo "No content to execute."
      fi
    done
    rm "$temp_file"
}