RED='\033[0;31m'
CYAN='\033[0;36m'
BLUE='\033[0;34m'
NC='\033[0m'

function red() {
  echo "${RED}$@${NC}"
}

function cyan() {
  echo "${CYAN}$@${NC}"
}

function blue() {
  echo "${BLUE}$@${NC}"
}

function info() {
  blue $@
}

info "ZSH loaded"

export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
export ZSH=/Users/georgegillams/.oh-my-zsh

export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export ANDROID_HOME="$ANDROID_SDK_ROOT"
export TERM="xterm-256color"
export GPG_TTY=$(tty)

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status battery root_indicator background_jobs history time)

ZSH_THEME="powerlevel10k/powerlevel10k"

HIST_STAMPS="dd/mm/yyyy"

plugins=(git osx)

source $ZSH/oh-my-zsh.sh
source $ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# set -o vi

# ========================== SYSTEM ==========================

alias whence-function='echo "use declare -f FUNC"'

alias duplicate-tab='open . -a iterm'

alias zsh-remove-api-keys-from-history='zsh-remove-term-from-history APIKEY && zsh-remove-term-from-history API_KEY'
function zsh-remove-term-from-history() { cat ~/.zsh_history | grep -v $@ > ~/.zsh_history_updated && sleep 2 && cp ~/.zsh_history_updated ~/.zsh_history && rm ~/.zsh_history_updated && echo "Quit iTerm to finish the job\!" }
alias zsh-rebuild='dotfiles-save-zshrc && cd - && . ~/.zshrc'
alias tmux-rebuild='dotfiles-save-tmux-conf && cd - && tmux source-file ~/.tmux.conf'
alias vim-rebuild='vim +"source ~/.vimrc" +PluginInstall +qall && dotfiles-save-vimrc && cd -'
alias zsh-edit-config='code ~/.zshrc'
alias tmux-edit-config='vim ~/.tmux.conf'
alias dropbox-link-desktop='ln -s /Users/georgegillams/Dropbox/Desktop ./Desktop'
alias dropbox='cd ~/Dropbox'
alias documents='cd ~/Documents'
alias desktop='cd ~/Desktop'
alias gradle-clear-cache='rm -rf $HOME/.gradle/caches/'

alias nvm-fix-erbium-npm-version='nvm use 13.0.0 && nvm uninstall lts/erbium && nvm install lts/erbium && nvm alias default lts/erbium'

alias pingu='open https://www.youtube.com/watch?v=Nozh1zDj8_o'
alias very-nice='vlc --play-and-exit ~/Documents/georgegillams/dotfiles/very-nice.mp3'

alias weather-portsmouth='curl wttr.in/Portsmouth'
alias weather-london='curl wttr.in/London'
alias weather='weather-london';

function launch-zoom-meeting-legacy() {
  osascript ~/Documents/georgegillams/dotfiles/apple\ script/launch-zoom.scpt $@
}
function launch-zoom-meeting() {
  open /Applications/zoom.us.app && sleep 3 && https://skyscanner.zoom.us/j/$1
}
alias personal-zoom='launch-zoom-meeting $(cat ~/Dropbox/secrets/personalzoomrc)'
alias backpack-zoom='launch-zoom-meeting $(cat ~/Dropbox/secrets/backpackzoomrc)'
alias fika-zoom='launch-zoom-meeting $(cat ~/Dropbox/secrets/fikazoomrc)'
alias zoom='personal-zoom'
alias zoom-backpack='backpack-zoom'
alias zoom-personal='personal-zoom'

alias vim-edit-config='code ~/.vimrc'
alias season-ticket='open ~/Desktop/season_ticket.jpg'

function list-processes-on-port() { sudo lsof -i :$@ }
function list-process-pids-on-port() { list-processes-on-port $@ | grep -v PID | awk '{print $2}' }
function kill-processes-on-port() { for pid in $(list-process-pids-on-port $@); do kill-process $pid; done }
alias kill-process='sudo kill -9'

alias system-flush-dns-cache="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias system-sleep="pmset sleepnow"
alias system-clear-asl="sudo rm -rf /private/var/log/asl/*.asl"
alias system-clean-desktop="mv ~/Desktop/* ~/.Trash/ && mv ~/.Trash/season_ticket* ~/Desktop/"
alias system-fix-audio="sudo kill -9 `ps ax|grep 'coreaudio[a-z]' | awk '{print $1}'`"
alias system-fix-finder-lagging="mv ~/Library/Preferences/com.apple.finder.plist ~/Desktop/ && echo \"NOW RESTART. IF EVERYTHING IS FINE, DELETE ~/Desktop/com.apple.finder.plist\""
alias system-fix-sound="system-fix-audio"
alias system-fix-vimrc-location="mkdir -p ~/.config/vim && echo 'source ~/.vimrc' > ~/.config/vim/init.vim"
alias system-open-ms-updater="open /Library/Application\ Support/Microsoft/MAU2.0/Microsoft\ AutoUpdate.app"
alias system-open-sketch-updater="open /Applications/Sketch.app"
alias system-open-cc-updater="open /Applications/Adobe\ Creative\ Cloud/Adobe\ Creative\ Cloud"
alias system-update-brew-apps="brew update && brew outdated && brew upgrade && brew cask outdated && brew cask upgrade"
alias system-update-apps="system-update-brew-apps & (mas outdated && mas upgrade) & system-open-ms-updater & system-open-sketch-updater & system-open-cc-updater"
alias system-fix-spotlight='sudo mdutil -E'
alias system-fix-ssh='ssh-add -K ~/.ssh/id_rsa &>/dev/null'
alias system-fix-gpg='(gpg-agent --daemon || true) && gpg-agent --default-cache-ttl 2592000 && gpg -s ~/.zshrc && rm ~/.zshrc.gpg'
alias system-disable-spotlight='mv /System/Library/LaunchAgents/com.apple.Spotlight.plist /System/Library/LaunchAgents/com.apple.Spotlight.plist.BAK && mv /System/Library/LaunchDaemons/com.apple.metadata.mds.plist /System/Library/LaunchDaemons/com.apple.metadata.mds.plist.BAK'
alias system-disable-indexing='sudo mdutil -a -i off'
alias system-reset-canary='sudo rm -rf /Applications/Canary\ Mail.app && sudo rm -rf ~/Library/Containers/io.canarymail.mac/'
alias system-show-hidden-files='defaults write com.apple.finder AppleShowAllFiles YES'
alias system-fix-rvm-openssl='brew reinstall openssl --ignore-dependencies && brew upgrade ruby-build rbenv'
alias web-browser='w3m'

alias improve-vpn-connection='cd ~/Documents/laz_l/local-vpn-routing && git-reset && gml && sudo ./tunnel_vpn.py'
alias tunnel-vpn-connection='improve-vpn-connection'

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

alias npm-check-unused-dependencies='npm install depcheck -g && depcheck'

# ========================== NPM ==========================

npm-set-normal-registry() {
  npm config set registry https://registry.npmjs.org/
}
alias npm-set-artifatory-registry='npm config set registry https://artifactory.skyscannertools.net/artifactory/api/npm/npm/'
alias npm-upgrade-major-dependencies='npx npm-check-updates -u'
alias npm-upgrade-minor-dependencies='npx npm-check-updates -u --semverLevel major'
alias npm-upgrade-patch-dependencies='npx npm-check-updates -u --semverLevel minor'

# ============================================================

# ========================= CLANG =========================

alias clang-all-the-things='clang-format -i **/*.h **/*.m'

# ============================================================

alias xcode='open'
alias xcode-delete-derived-data='rm -rf ~/Library/Developer/Xcode/DerivedData/ && mkdir ~/Library/Developer/Xcode/DerivedData'
alias xcode-fix-AST-error='rm -rf ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex'
alias xcode-fix-select='sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer/'

alias AndroidStudio="open -a /Applications/Android\ Studio.app"

alias jest-run-specific-tests='npx jest BpkBannerAlert'
alias jest-fix-specific-tests='npx jest -u BpkBannerAlert'

alias redis-reset='redis-cli flushall && redis-cli flushall && redis-cli flushall && redis-cli flushall && redis-cli flushall'

alias budget='cd ~/Dropbox/Year\ Plan/2017\ -\ 2018/ && open Budgetting_new.numbers'
alias finances='cd ~/Dropbox/Year\ Plan/ && open Financej.numbers'

alias wedding='cd ~/Dropbox/Wedding/'
alias wedding-guest-list='wedding && open guestlist.numbers'

alias npm-clear-cache='npm cache clean --force && npm cache clear --force && watchman watch-del-all && sudo rm -rf $TMPDIR/react-* && sudo rm -rf node_modules/'

alias get-email-old='echo "georgegillams@hotmail.co.uk" | pbcopy'
alias get-email='echo "g@georgegillams.co.uk" | pbcopy'
alias get-email-work='echo "george.gillams@skyscanner.net" | pbcopy'
alias get-phone='echo "+447867592615" | pbcopy'
alias get-phone-local='echo "07867592615" | pbcopy'

function gif-make-loop-forever() { convert -delay 5 -loop 0 $@ $@ }

alias travis-fold-start='echo -e "travis_fold:start:$1\033[33;1m$2\033[0m"'
alias travis-fold-end='echo -e "\ntravis_fold:end:$1\r"'

alias optimise-all-pngs='find . -name "*.png" -exec imageoptim {} \;'

alias gh-prs='gh pr list'
alias gh-create-pr='gh pr create'

alias git-branch='git branch'
alias git-show-me-how-to-view-a-forked-branch='echo "gco -b username-branch-name master\ngit pull https://github.com/username/backpack.git branch-name"'
alias git-show-me-how-to-unfold-all-rich-diffs='echo "const toClick = document.querySelectorAll(\`[aria-label=\"Display the rich diff\"]\`);
for (let i = toClick.length - 1; i >= 0; i -= 1){
toClick[i].click();
}" | pbcopy'
alias git-show-me-how-to-unfold-all-gh-long-diffs='echo "const toClick = document.getElementsByClassName(\"load-diff-button btn-link width-full\");
for (let i = toClick.length - 1; i >= 0; i -= 1){
toClick[i].click();
}" | pbcopy'
alias git-show-me-how-to-unfold-all-gh-comments='echo "const toClick = document.getElementsByClassName(\"btn-link text-gray float-right f6 outdated-comment-label show-outdated-button js-details-target\");
for (let i = toClick.length - 1; i >= 0; i -= 1){
toClick[i].click();
}" | pbcopy'
alias show-me-how-to-click-all-the-buttons='echo "const buttons = document.getElementsByTagType(\"BUTTON\");
for (let i = buttons.length - 1; i >= 0; i -= 1){
  const button = buttons[i];
  if(button.getAttribute(\"aria-label\") === \"Move rule down: FORWARD TO GEORGEGILLAMS.CO.UK\"){
   console.log(button)
    button.click();
    console.log(\"clicked\");
  }
}" | pbcopy'
alias git-prepend-branch-name='node ~/Documents/georgegillams/dotfiles/prepend-ticket.js'
alias git-rebase-keep-their-changes='git checkout --ours . && git add . && git rebase --continue'
alias git-rebase-keep-our-changes='git checkout --theirs . && git add . && git rebase --continue'
alias git-gc-prune-aggressive='git gc --prune=now --aggressive && git repack'
alias git-master-latest-actual='gco master && git-fetch && git reset --hard origin/master && git pull && (git branch -D $(git-branch | grep -v "master") || true) && git submodule update && git-reset'
alias git-develop-latest-actual='gco develop && git-fetch && git reset --hard origin/develop && git pull && (git branch -D $(git-branch | grep -v "develop") || true) && git submodule update && git-reset'
alias gml=' if [[ $(pwd) == *"skyscanner-app"* ]]; then git-develop-latest-actual; else git-master-latest-actual; fi'
alias gaa-no-image-optimisation='git add .'
alias git-partial-add='git-pre-push && git add -p'
alias gaa='git-pre-push && gaa-no-image-optimisation && node ~/Documents/georgegillams/dotfiles/image-optim.js && gaa-no-image-optimisation'
alias git-reset='git-pre-push && gaa-no-image-optimisation && git reset --hard HEAD && git reset --recurse-submodules'
alias git-reset-unstaged='git checkout -- .'
alias git-fetch='git fetch --all'
alias grm-actual='git-fetch && (git rebase origin/master | grep CONFLICT || true) && git-submodules-pull'
alias git-rebase-develop-actual='git-fetch && (git rebase origin/develop | grep CONFLICT || true) && git-submodules-pull'
alias grm=' if [[ $(pwd) == *"skyscanner-app"* ]]; then git-rebase-develop-actual; else grm-actual; fi'
alias gri='git rebase -i'
alias git-rebase-upstream='echo "ensure upstream is set using `git remote add upstream <URL>`" && git fetch upstream && git merge upstream/master && git push origin origin/master'
alias git-pre-push='git status && sleep 3'
alias git-rename-last-commit='git commit --amend'
alias gamp='git-pre-push && gcn! --no-verify && gpf'
alias gamp-with-verification='git-pre-push && gcn! && gpf-with-verification'
alias git-test-amend-push='fixtest && git add . && gitamendpush'
alias gpf-with-verification='ggf && git push --set-upstream $(git remote) $(git branch | grep \* | cut -d " " -f2)'
alias gpf='(ggf --no-verify || true) && git push --set-upstream $(git remote) $(git branch | grep \* | cut -d " " -f2)'
alias git-yolo='gpf'
alias git-clear-cache='git rm -r --cached . && git add . && git commit -m && git push ~'
function gcmp() { git-pre-push && git commit -m "$(git-prepend-branch-name $@)" --no-verify && gpf }
function gcmp-with-verification() { git-pre-push && git commit -m $@ && gpf-with-verification }
function git-make-mr() { touch remove.txt && gaa && gcmp $@ && rm remove.txt && gaa && gcmp "squash me" }
function git-revert-to-master-actual() { git checkout origin/master $@ }
function git-revert-to-develop-actual() { git checkout origin/develop $@ }
function git-revert-to-master() {  if [[ $(pwd) == *"skyscanner-app"* ]]; then git-revert-to-develop-actual $@ ; else git-revert-to-master-actual $@ ; fi }
function whoamip() { ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' }
function git-rename-branch() {
  oldBranchName=$(git branch | grep \* | cut -d " " -f2)
  newBranchName=$1
  git-branch -m $newBranchName && git push origin :$oldBranchName $newBranchName && git push origin -u $newBranchName
}
alias gclean='git clean -xdf'
alias git-move-changes-to-clean-branch='sudo rm -rf ~/Desktop/back/* && git-clean && mv ./* ~/Desktop/back/ && git-reset && gml && mv ~/Desktop/back/* ./'
alias git-pull-fork='node ~/Documents/georgegillams/dotfiles/pull-forked-branch.js'
alias git-submodules-init='git submodule update --init --recursive'
alias git-submodules-pull='git submodule update --recursive --remote'
alias git-disable-gpg='open ~/.gitconfig and remove signingKey and gpg values'
alias git-enable-gpg='revert your changes to ~/.gitconfig'

alias docker-reset='docker ps -a -q | xargs -L1 docker rm --force'
alias docker-reset-hard='docker-reset && docker system prune -a'
alias docker-reset-images='docker ps -a -q | xargs -L1 docker rmi --force'
alias docker-reset-complete='docker-reset && docker-reset-images'
alias docker-list-processes='docker ps -a'
alias docker-list-ips='docker inspect -f "{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" $(docker ps -aq)'
alias docker-list-ports='docker inspect --format="{{range $p, $conf := .NetworkSettings.Ports}} {{$p}} -> {{(index $conf 0).HostPort}} {{end}}" $(docker ps -aq)'
alias docker-start-all='docker start $(docker ps -aq)'
alias docker-pull-sql-image='docker pull microsoft/mssql-server-linux:2017-latest'

alias c='code ./'

alias lightroom-delete-preview-files='find . -name "*Previews.lrdata" -exec rm -rf {} \;'

# ==================== PERSONAL PROJECTS =====================

alias daily-backup="(ge-backup) && (cg-backup)"

alias aws-config='cd ~/Documents/georgegillams/aws/'

alias dotfiles='cd ~/Documents/georgegillams/dotfiles/'
alias dotfiles-nuke='cd ~/Documents/georgegillams/ && sudo rm -rf dotfiles && git clone git@github.com:georgegillams/dotfiles.git'
alias dotfiles-save-tmux-conf='dotfiles && cp ~/.tmux.conf ./ && gaa && gcmp "Update TMUX conf"'
alias dotfiles-save-zshrc='dotfiles && cp ~/.zshrc ./ && gaa && gcmp "Update ZSHRC"'
alias dotfiles-save-vimrc='dotfiles && cp ~/.vimrc ./ && gaa && gcmp "Update VIMRC"'
alias dotfiles-edit-install-script='(dotfiles && cd system-install && c)'
alias brew-edit-install-script='dotfiles-edit-install-script'
alias dotfiles-commit-brew-script='dotfiles && gaa && gcmp "Update brew install script"'
alias dotfiles-save-vscode-settings='dotfiles && cp ~/Library/Application\ Support/Code/User/*.json ./vscode/ && gaa && gcmp "Update vscode settings"'
# alias dotfiles-save-greasemonkey='dotfiles && cp ~/.vimrc ./ && gaa && gcmp "Update NVIMRC"'

alias academic-references='cd ~/Documents/georgegillams/react-component-academic-reference/'
alias academic-references-nuke='cd ~/Documents/georgegillams/ && sudo rm -rf react-component-academic-reference && git clone git@github.com:georgegillams/react-component-academic-reference.git'
alias academic-references-setup='academic-references && cd package && npm ci && cd ../example && npm i && academic-references'
alias academic-references-run-web-app='academic-references && cd example && npm run start'
alias academic-references-publish='academic-references && cd package && npm publish'

alias browser-scripts='cd ~/Documents/georgegillams/browser-scripts/'
alias browser-scripts-commit='browser-scripts && browser-scripts-build-readme && gaa && gcmp "Update scripts"'
alias browser-scripts-nuke='cd ~/Documents/georgegillams/ && sudo rm -rf browser-scripts && git clone git@github.com:georgegillams/browser-scripts.git'
alias browser-scripts-build-readme='browser-scripts && npm run build:readme'

alias chewbacca-ssh-ec2='ssh ubuntu@ec2-3-9-19-209.eu-west-2.compute.amazonaws.com'
alias r2d2-ssh-ec2='ssh ubuntu@ec2-35-178-235-11.eu-west-2.compute.amazonaws.com'

alias ge='cd ~/Documents/georgegillams/georgegillams.co.uk/'
alias ge-nuke='cd ~/Documents/georgegillams/ && sudo rm -rf georgegillams.co.uk && git clone git@github.com:georgegillams/georgegillams.co.uk.git'
alias ge-container-docs='ge && open ~/Dropbox/georgegillams.co.uk/Containers.numbers'
alias ges='ge && PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true npm ci && npm run prebuild'
alias ge-rebase='cd ~/Documents/flexdinesh/react-redux-boilerplate && gml && ge && cp -R ../react-redux/* ./'
alias ge-backup='ge && node scripts/backup-production-data.js'
alias ge-docker-build-image='ge && docker build -t georgegillams-test -f Dockerfile.backstopjstest .'
alias ge-docker-create-and-run-container='ge && docker run -itd -e PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true georgegillams-test bash'
function ge-docker-run-tests () {
  ge
  containerId=$(docker ps -a | grep georgegillams-test | awk '{print $1}')
  docker cp .babelrc $containerId:/usr/src/tmp/
  docker cp app $containerId:/usr/src/tmp/
  docker cp backstop_data $containerId:/usr/src/tmp/
  docker cp config $containerId:/usr/src/tmp/
  docker cp helpers $containerId:/usr/src/tmp/
  docker cp jest.config.js $containerId:/usr/src/tmp/
  docker cp package-lock.json $containerId:/usr/src/tmp/
  docker cp package.json $containerId:/usr/src/tmp/
  docker cp scripts $containerId:/usr/src/tmp/
  docker cp server $containerId:/usr/src/tmp/
  docker exec -it $containerId npm ci
  docker exec -it $containerId npm run build
  docker exec -it $containerId npm run test
  docker exec -it $containerId npm run backstopjs:test:allow-failure
}
function ge-docker-copy-snapshots-to-host () {
  ge
  containerId=$(docker ps -a | grep georgegillams-test | awk '{print $1}')
  docker cp $containerId:/usr/src/tmp/backstop_data ./
}
alias ge-regenerate-snapshots='ge && docker-reset && ge-docker-create-and-run-container && ge-docker-run-tests && ge-docker-copy-snapshots-to-host'

alias cg='cd ~/Documents/georgegillams/cgwedding/'
alias cg-nuke='cd ~/Documents/georgegillams/ && sudo rm -rf cgwedding && git clone git@github.com:georgegillams/cgwedding.git'
alias cg-setup='cg && PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true npm ci && npm run prebuild'
alias cg-rebase='cd ~/Documents/flexdinesh/react-redux-boilerplate && gml && cg && cp -R ../react-redux/* ./'
alias cg-backup='cg && node scripts/backup-production-data.js'
alias cg-docker-build-image='cg && docker build -t cgwedding-test -f Dockerfile.backstopjstest .'
alias cg-docker-create-and-run-container='cg && docker run -itd -e PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true cgwedding-test bash'
function cg-docker-run-tests () {
  cg
  containerId=$(docker ps -a | grep cgwedding-test | awk '{print $1}')
  docker cp .babelrc $containerId:/usr/src/tmp/
  docker cp app $containerId:/usr/src/tmp/
  docker cp backstop_data $containerId:/usr/src/tmp/
  docker cp config $containerId:/usr/src/tmp/
  docker cp helpers $containerId:/usr/src/tmp/
  docker cp jest.config.js $containerId:/usr/src/tmp/
  docker cp package-lock.json $containerId:/usr/src/tmp/
  docker cp package.json $containerId:/usr/src/tmp/
  docker cp scripts $containerId:/usr/src/tmp/
  docker cp server $containerId:/usr/src/tmp/
  docker exec -it $containerId rm -rf backstop_data/bitmaps_reference
  docker exec -it $containerId npm ci
  docker exec -it $containerId npm run build
  docker exec -it $containerId npm run test
  docker exec -it $containerId npm run backstopjs:test:allow-failure
}
function cg-docker-copy-snapshots-to-host () {
  cg
  containerId=$(docker ps -a | grep cgwedding-test | awk '{print $1}')
  docker cp $containerId:/usr/src/tmp/backstop_data ./
}
alias cg-regenerate-snapshots='cg && docker-reset && cg-docker-create-and-run-container && cg-docker-run-tests && cg-docker-copy-snapshots-to-host'

alias reduxdefinitions='cd ~/Documents/georgegillams/redux-definitions/'
alias reduxdefinitions-nuke='cd ~/Documents/georgegillams/ && sudo rm -rf redux-definitions && git clone git@github.com:georgegillams/redux-definitions.git'
alias reduxdefinitions-setup='reduxdefinitions && npm ci && npm run transpile && npm run dev:install'

alias ggc='cd ~/Documents/georgegillams/gg-components/'
alias ggc-nuke='cd ~/Documents/georgegillams/ && sudo rm -rf gg-components && git clone git@github.com:georgegillams/gg-components.git'
alias ggcs='ggc && PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true npm ci'
alias ggc-docker-build-image='ggc && docker build -t gg-components-test -f Dockerfile.backstopjstest .'
alias ggc-docker-create-and-run-container='ggc && docker run -itd -e PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true gg-components-test bash'
function ggc-docker-run-tests () {
  ggc
  containerId=$(docker ps -a | grep gg-components-test | awk '{print $1}')
  docker cp .storybook $containerId:/usr/src/tmp/
  docker cp babel.config.js $containerId:/usr/src/tmp/
  docker cp backstop_data $containerId:/usr/src/tmp/
  docker cp config $containerId:/usr/src/tmp/
  docker cp package-lock.json $containerId:/usr/src/tmp/
  docker cp package.json $containerId:/usr/src/tmp/
  docker cp scripts $containerId:/usr/src/tmp/
  docker cp src $containerId:/usr/src/tmp/
  docker cp test $containerId:/usr/src/tmp/
  docker exec -it $containerId rm -rf backstop_data/bitmaps_reference
  docker exec -it $containerId npm ci
  docker exec -it $containerId npm run build
  docker exec -it $containerId npm run test
  docker exec -it $containerId npm run backstopjs:test:allow-failure
}
function ggc-docker-copy-snapshots-to-host () {
  ggc
  containerId=$(docker ps -a | grep gg-components-test | awk '{print $1}')
  docker cp $containerId:/usr/src/tmp/backstop_data ./
}
alias ggc-regenerate-snapshots='ggc && docker-reset && ggc-docker-create-and-run-container && ggc-docker-run-tests && ggc-docker-copy-snapshots-to-host'

alias sra='cd ~/Documents/georgegillams/screen-reader-adventures/'
alias sra-nuke='cd ~/Documents/georgegillams/ && sudo rm -rf screen-reader-adventures && git clone git@github.com:georgegillams/screen-reader-adventures.git'
alias sras='sra && npm ci'
alias sra-docker-build-image='sra && docker build -t screen-reader-adventures-test -f Dockerfile.backstopjstest .'
alias sra-docker-create-and-run-container='sra && docker run -itd -e PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true screen-reader-adventures-test bash'
function sra-docker-run-tests () {
  sra
  containerId=$(docker ps -a | grep screen-reader-adventures-test | awk '{print $1}')
  docker cp .storybook $containerId:/usr/src/tmp/
  docker cp babel.config.js $containerId:/usr/src/tmp/
  docker cp backstop_data $containerId:/usr/src/tmp/
  docker cp config $containerId:/usr/src/tmp/
  docker cp package-lock.json $containerId:/usr/src/tmp/
  docker cp package.json $containerId:/usr/src/tmp/
  docker cp scripts $containerId:/usr/src/tmp/
  docker cp src $containerId:/usr/src/tmp/
  docker cp test $containerId:/usr/src/tmp/
  docker exec -it $containerId rm -rf backstop_data/bitmaps_reference
  docker exec -it $containerId npm ci
  docker exec -it $containerId npm run build
  docker exec -it $containerId npm run test
  docker exec -it $containerId npm run backstopjs:test:allow-failure
}
function sra-docker-copy-snapshots-to-host () {
  sra
  containerId=$(docker ps -a | grep screen-reader-adventures-test | awk '{print $1}')
  docker cp $containerId:/usr/src/tmp/backstop_data ./
}
alias sra-regenerate-snapshots='sra && docker-reset && sra-docker-create-and-run-container && sra-docker-run-tests && sra-docker-copy-snapshots-to-host'

alias epicc-ticket-sales='cd ~/Documents/georgegillams/epicc-ticket-sales/'
alias epicc-ticket-sales-nuke='cd ~/Documents/georgegillams/ && sudo rm -rf epicc-ticket-sales && git clone git@github.com:georgegillams/epicc-ticket-sales.git'
alias epicc-ticket-sales-setup='epicc-ticket-sales && npm i'
alias epicc-ticket-sales-backup='dotfiles && node epicc-conference-backup.js && cd -'

# ============================================================

# ======================== SKYSCANNER ========================

alias bd='cd ~/Documents/Skyscanner/backpack-docs/'
alias backpack-setup='bd && npm i && npm run build-backpack && git-submodules-init'
alias bd-run-tests='bd && (pkill flow | true) && npm test'
alias bd-git-submodules-reset='bd && git checkout origin/master backpack-android backpack-ios backpack-react-native && git submodule update --init --recursive'
alias bd-watch-tests='bd && npm run jest:watch'
alias bd-run-flow='bd && (pkill flow | true) && npm run flow'
alias bds='bd && npm i'
alias bd-nuke='cd ~/Documents/Skyscanner/ && sudo rm -rf backpack-docs/ && git clone --recursive git@github.com:Skyscanner/backpack-docs.git'
alias bd-nuke-setup='bd-nuke && bds'
alias bdr='bd && BPK_BUILT_AT=$( date -u +%s ) npx webpack-dev-server --open'

alias backpack-publish-all-packages='backpack && cd packages && find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}' && npm publish" \;'

alias kr-disable-codesign='kr codesign off'
alias kr-enable-codesign='kr codesign on'

alias bw='cd ~/Documents/Skyscanner/backpack/'
alias bw-fix-tests='bw && find . -name "*.js.snap" -exec rm -rf {} \; && npm test'
alias bw-run-tests='bw && (pkill flow | true) && npm test'
alias bw-watch-tests='bw && npm run jest:watch'
alias bw-release='bw && system-fix-ssh && git-disable-gpg && npx lerna publish && git-enable-gpg && echo "Now run npm run publish:css"'
alias bw-run-flow='bw && (pkill flow | true) && npm run flow'
alias bws='bw && npm i && npm run build'
alias bw-nuke='cd ~/Documents/Skyscanner/ && sudo rm -rf backpack/ && git clone --recursive git@github.com:Skyscanner/backpack.git'
alias bw-nuke-setup='bw-nuke && bws'
alias bwr='bw && npm start'
alias bw-check-cross-dependencies='bw && node ~/Dropbox/Skyscanner/Backpack/check-bpk-dependencies.js'
alias bw-fix-cross-dependencies='bw && node ~/Dropbox/Skyscanner/Backpack/check-bpk-dependencies.js --fix'
alias bw-clean-icons='sudo rm -rf packages/bpk-svgs/dist/png'
alias bw-check-outdated-npm-packages='for dir in `ls packages`
do
  (cd ./packages/$dir && npm outdated);
done'
alias bw-check-outdated-top-level='npm outdated'
alias bw-output-all-outdated='bw && (bw-check-outdated-top-level > ~/Desktop/outdated.txt) & (sleep 5 && bw-check-outdated-npm-packages >> ~/Desktop/outdated.txt && backpack-check-outdated-npm-packages-native >> ~/Desktop/outdated_native.txt) && cat ~/Desktop/outdated.txt | less'
alias bw-create-pr-for-manual-update-dependencies='git-clean && bws && bw-run-tests && gco -b no-jira-update-dependencies && gaa && gcmp "[NO-JIRA] Update dependencies"'

alias bw-release-tokens-beta='backpack && npm run build:tokens && gaa && gamp && (cd packages/bpk-tokens && npm publish --tag beta)'

alias update-backpack-npm-dependencies='npx npm-check-updates -u "/^bpk-.*$/"'
alias create-bpk-dep-pr='gco -b NO-JIRA-update-bpk-dependencies && gaa && gcmp "Update bpk dependencies" && open https://github.com/Skyscanner/$(basename "`pwd`")/pull/new/NO-JIRA-update-bpk-dependencies'
alias backpack-propogate-changes='bi && update-backpack-npm-dependencies && ba && update-backpack-npm-dependencies && brn && update-backpack-npm-dependencies && bi && npm i && bis && create-bpk-dep-pr && brs && create-bpk-dep-pr && bas && create-bpk-dep-pr'

alias brn='cd ~/Documents/Skyscanner/backpack-react-native/'
alias brn-fix-tests='brn && find . -name "*.js.snap" -exec rm -rf {} \; && npm test'
alias brn-run-tests='brn && (pkill flow | true) && npm test'
alias brn-watch-tests='brn && npm run jest:native:watch'
alias brn-run-flow='brn && (pkill flow | true) && npm run flow'
alias brn-copy-font-files='cp ./node_modules/bpk-svgs/dist/font/* ./android/app/src/main/assets/fonts/'
alias brns='brn && touch android/local.properties && npm ci && cd ios/ && bundle exec pod repo update && bundle exec pod install --repo-update && brn && brn-copy-font-files'
alias brno='brn && open ios/native.xcworkspace'
alias brnso='brns && brno'
alias brn-release='brn && cp ~/Dropbox/secrets/brn-local-properties ./android/local.properties && npm run release'
alias brn-publish='brn-release'
alias brn-nuke='cd ~/Documents/Skyscanner/ && sudo rm -rf backpack-react-native/ && git clone git@github.com:Skyscanner/backpack-react-native.git'
alias brn-nuke-setup='brn-nuke && brs'
alias brn-run-android='brn && ($ANDROID_SDK_ROOT/emulator/emulator -avd NEXUS_5X_API_28 || true) & npm run android'
alias brn-run-android-old='brn && ($ANDROID_SDK_ROOT/emulator/emulator -avd NEXUS_4_API_24 || true) & npm run android'
alias brn-run-android-docs='brn && ($ANDROID_SDK_ROOT/emulator/emulator -avd NEXUS_5_API_27 || true) & npm run android'
alias brn-run-ios='brn && npx react-native run-ios --simulator="iPhone 11"'
alias brn-run-ios-docs='brn && npx react-native run-ios --simulator="iPhone 8"'
alias brnr='brn && (npm start & npm run storybook)'
alias brn-check-cross-dependencies='brn && node ~/Dropbox/Skyscanner/Backpack/check-bpk-dependencies.js'
alias brn-fix-cross-dependencies='brn && node ~/Dropbox/Skyscanner/Backpack/check-bpk-dependencies.js --fix'

alias backpack-install-android-device='$ANDROID_SDK_ROOT/tools/bin/sdkmanager "system-images;android-24;google_apis;x86" && $ANDROID_SDK_ROOT/tools/bin/avdmanager create avd --name "bpk-avd" --package "system-images;android-24;google_apis;x86" --device "Nexus 5X"'
alias backpack-install-ruby-version='backpack && rbenv install $(cat native/ios/.ruby-version)'

alias backpack-react-scripts='cd ~/Documents/Skyscanner/backpack-react-scripts/'
alias backpack-react-scripts-setup='backpack-react-scripts && yarn && cd packages/react-error-overlay && yarn && backpack-react-scripts'
alias backpack-react-scripts-nuke='cd ~/Documents/Skyscanner/ && sudo rm -rf backpack-react-scripts/ && git clone git@github.com:Skyscanner/backpack-react-scripts.git'
alias backpack-react-scripts-nuke-setup='backpack-react-scripts-nuke && backpack-react-scripts-setup'
alias backpack-react-scripts-publish='backpack-react-scripts && git-reset && npm run publish -- --scope backpack-react-scripts'
alias backpack-react-scripts-release='backpack-react-scripts-publish'

alias backpack-node-sass='cd ~/Documents/Skyscanner/backpack-node-sass/'
alias backpack-node-sass-setup='backpack-node-sass && npm i'
alias backpack-node-sass-nuke='cd ~/Documents/Skyscanner/ && sudo rm -rf backpack-node-sass/ && git clone git@github.com:Skyscanner/backpack-node-sass.git'
alias backpack-node-sass-nuke-setup='backpack-node-sass-nuke && backpack-node-sass-setup'

alias bl='cd ~/Documents/Skyscanner/bl/'
alias bls='bl && npm i && npx gulp'
alias bl-nuke='cd ~/Documents/Skyscanner/ && sudo rm -rf bl/ && git clone git@github.skyscannertools.net:backpack/bl.git'
alias bl-nuke-setup='bl-nuke && bls'

alias bi='cd ~/Documents/Skyscanner/backpack-ios/'
alias bis='bi && bundle install && nvm use && npm ci && (cd Example && bundle install && bundle exec pod update) && npx gulp'
alias bio='bi && open Example/Backpack.xcworkspace'
alias biso='bis && bio'
alias biso-complete='git-clean && xcode-delete-derived-data && biso'
alias bi-nuke='cd ~/Documents/Skyscanner/ && sudo rm -rf backpack-ios/ && git clone git@github.com:Skyscanner/backpack-ios.git'
alias bi-nuke-setup='bi-nuke && bis'
alias bi-install-ruby-version='bi && rvm install ruby-$(cat .ruby-version)'
alias bi-release='bi && BUILD_SDK=iphonesimulator13.2 DESTINATION="platform=iOS Simulator,name=iPhone 8" bundle exec rake release'
alias bi-publish='bi-release'
alias bi-build-ipa='bi && sh ~/Dropbox/secrets/backpack-ios/backpack-build-ipa && git-reset'
alias bi-test='bi && BUILD_SDK=iphonesimulator13.2 DESTINATION="platform=iOS Simulator,name=iPhone 8" bundle exec rake test && Example/Pods/SwiftLint/swiftlint lint --strict'
alias bi-swiftlint='(cd Example && Pods/SwiftLint/swiftlint lint --strict --config .swiftlint.yml)'
alias bi-lint='bi && rake lint && bi-swiftlint'
alias bi-clang-format='bi && (cd Backpack && clang-all-the-things) && (cd Example && clang-all-the-things)'
alias bi-clean-status-bar='xcrun simctl status_bar "iPhone 8" override --time "09:41" --wifiBars 3 --cellularBars 4 --batteryLevel 100 --operatorName Backpack'
alias bi-take-screenshots-basic='bi && rake take_screenshots'
alias bi-keep-status-bar-clean='sleep 5 && for i in {1..30}; do bi-clean-status-bar; sleep 30; done'
alias bi-take-screenshots='bi-take-screenshots-basic & bi-keep-status-bar-clean'

alias ba='cd ~/Documents/Skyscanner/backpack-android/'
alias bas='ba && npm i && npm run build'
alias bao='ba && AndroidStudio ./'
alias baso='bas && bao'
alias ba-nuke='cd ~/Documents/Skyscanner && sudo rm -rf backpack-android/ && git clone git@github.com:Skyscanner/backpack-android.git'
alias ba-nuke-setup='ba-nuke && bas'

alias backpack-get-slack-theme='echo "Backpack Slack theme: \`#252033,#524C61,#E6E4EB,#252033,#524C61,#FFFFFF,#00D775,#FFBB00\`"'

alias fullstack='cd ~/Documents/Skyscanner/full-stack-recruitment-test/'
alias fullstack-run='fullstack && npm run client & node server/src/server.js'
alias fullstack-setup='fullstack && npm i'
alias fullstack-nuke='cd ~/Documents/Skyscanner/ && sudo rm -rf full-stack-recruitment-test/ && git clone git@github.com:Skyscanner/full-stack-recruitment-test.git'

alias artifactory-login='artifactory-cli-login npm -f && artifactory-cli-login pip -f'

alias sa='cd ~/Documents/apps-tribe/skyscanner-app/ && npm-set-artifatory-registry'
alias sarn-sanity-check='sa && (cd react-native && npm run pkglock:validate && npm i && npm run lint && npm run test)'
alias sa-nuke='cd ~/Documents/apps-tribe && rm -rf skyscanner-app && git clone git@github.skyscannertools.net:apps-tribe/skyscanner-app.git'
alias sas='sa && gem install bundler && (cd ios && rvm use 2.6.3 && ./fullsetup) && sa'
alias sao='sa && open ios/Project/Working/Skyscanner.xcworkspace'
alias saso='sas && sao'
alias sa-login-to-npm='sa && npm login --registry https://artifactory.skyscannertools.net/artifactory/api/npm/npm/'
alias sa-update-backpack-dependency='sa && (cd ios && bundle exec pod update Backpack)'
alias sa-fix-react-native-snapshots='sa && (cd react-native && npx jest --detectOpenHandles -u)'

alias pecha-kucha='cd ~/Dropbox/Skyscanner/Pecha\ Kucha/'
alias pecha-kucha-open='pecha-kucha && open pecha_kucha.key'

# ============================================================
info "Aliases ready"

export PATH=$HOME/.fastlane/bin:$HOME/.rvm/bin:/Users/georgegillams/.rvm/gems/ruby-2.3.1/bin:/usr/local/go/bin:/Users/georgegillams/bin:/Users/georgegillams/Library/Python/3.6/bin:/Users/georgegillams/.rvm/gems/ruby-2.3.1@global/bin:/Users/georgegillams/.rvm/rubies/ruby-2.3.1/bin:/usr/local/sbin:/Users/georgegillams/.cargo/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin:/Library/Frameworks/Mono.framework/Versions/Current/Commands:/Applications/Wireshark.app/Contents/MacOS:/Users/georgegillams/.rvm/bin:/Users/georgegillams/.vimpkg/bin
info "PATH defined"

# added by travis gem
[ -f /Users/georgegillams/.travis/travis.sh ] && source /Users/georgegillams/.travis/travis.sh
info "Travis integration done"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
info "iTerm shell integration tested"

# iTerm custom commands:
function iterm2_print_user_vars() {
  iterm2_set_user_var ipAddress $(ipconfig getifaddr en0)
  iterm2_set_user_var nodeVersion $(node -v)
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
}

system-fix-ssh

info "Loading NVM"
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh --no-use # This loads nvm
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm - disabled as it does the same as the line above
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion - disabled as it is too slow!
info "NVM ready"

#Auto switch nvm versions:
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  info "Loading Node version"
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    info "Reverting to nvm default version"
    nvm use default
  fi
}
load-ruby-version() {
  info "Loading Ruby version"
  if [[ -f .ruby-version && -r .ruby-version ]]; then
    rvm use
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    info "Reverting to rvm default version"
    rvm use default
  fi
}
add-zsh-hook chpwd npm-set-normal-registry
add-zsh-hook chpwd load-nvmrc
add-zsh-hook chpwd load-ruby-version
