export ZSH=/Users/georgegillams/.oh-my-zsh

export PATH="/usr/local/sbin:$PATH"

export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export ANDROID_HOME="$ANDROID_SDK_ROOT"
export TERM="xterm-256color"
export GPG_TTY=$(tty)

ZSH_THEME="powerlevel9k/powerlevel9k"
HIST_STAMPS="dd/mm/yyyy"

plugins=(git osx)

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# set -o vi

# ========================== SYSTEM ==========================

alias zsh-remove-api-keys-from-history='zsh-remove-term-from-history APIKEY && zsh-remove-term-from-history API_KEY'
function zsh-remove-term-from-history() { cat ~/.zsh_history | grep -v $@ > ~/.zsh_history_updated && sleep 2 && cp ~/.zsh_history_updated ~/.zsh_history && rm ~/.zsh_history_updated && echo "Quit iTerm to finish the job\!" }
alias zsh-rebuild='dotfiles-save-zshrc && cd - && . ~/.zshrc'
alias tmux-rebuild='dotfiles-save-tmux-conf && cd - && tmux source-file ~/.tmux.conf'
alias vim-rebuild='vim +"source ~/.vimrc" +PluginInstall +qall && dotfiles-save-vimrc && cd -'
alias zsh-edit-config='vim ~/.zshrc'
alias tmux-edit-config='vim ~/.tmux.conf'
alias brew-test-install-script='dotfiles && cp ./brew_install.sh ~/Desktop/ && cd .. && rm -rf dotfiles && rm -rf ~/.ssh/* && cd ~/Desktop && ./brew_install.sh'
alias brew-edit-install-script='vim ~/Documents/dotfiles/brew_install.sh'
function brew-install() { dotfiles && echo "\nbrew install $@" >> brew_install.sh && git-add-all && git-commit-push "Update brew script" && cd - && brew install $@ }
function brew-cask-install() { dotfiles && echo "\nbrew cask install $@" >> brew_install.sh && git-add-all && git-commit-push "Update brew script" && cd - && brew cask install $@ }
alias dropbox-link-desktop='ln -s /Users/georgegillams/Dropbox/Desktop ./Desktop'
alias dropbox='cd ~/Dropbox'
alias documents='cd ~/Documents'
alias desktop='cd ~/Desktop'
alias gradle-clear-cache='rm -rf $HOME/.gradle/caches/'

alias pingu='open https://www.youtube.com/watch?v=Nozh1zDj8_o'
alias very-nice='open https://www.youtube.com/watch?v=Y9X5Ar8jotk'

alias weather-portsmouth='curl wttr.in/Portsmouth'
alias weather-london='curl wttr.in/London'
alias weather='weather-london';

alias vim-edit-config='vim ~/.vimrc'
alias season-ticket='open ~/Desktop/season_ticket.jpg'

function list-processes-on-port() { sudo lsof -i :$@ }
function list-process-pids-on-port() { list-processes-on-port $@ | grep -v PID | awk '{print $2}' }
function kill-process() { sudo kill -9 $@ }
function kill-processes-on-port() { for pid in $(list-process-pids-on-port $@); do kill-process $pid; done }
alias system-sleep="pmset sleepnow"
alias system-clear-asl="sudo rm -rf /private/var/log/asl/*.asl"
alias system-fix-audio="sudo kill -9 `ps ax|grep 'coreaudio[a-z]' | awk '{print $1}'`"
alias system-fix-sound="system-fix-audio"
alias system-fix-vimrc-location="mkdir -p ~/.config/vim && echo 'source ~/.vimrc' > ~/.config/vim/init.vim"
alias system-open-ms-updater="open /Library/Application\ Support/Microsoft/MAU2.0/Microsoft\ AutoUpdate.app"
alias system-open-sketch-updater="open /Applications/Sketch.app"
alias system-open-cc-updater="open /Applications/Adobe\ Creative\ Cloud/Adobe\ Creative\ Cloud"
alias system-update-brew-apps="brew update && brew outdated && brew upgrade && brew cask outdated && brew cask upgrade"
alias system-update-apps="system-update-brew-apps & (mas outdated && mas upgrade) & system-open-ms-updater & system-open-sketch-updater & system-open-cc-updater"
alias system-fix-spotlight='sudo mdutil -E'
alias system-fix-ssh='ssh-add ~/.ssh/id_rsa &>/dev/null'
alias system-fix-ssh-neo='ssh-add ~/.ssh/id_rsa_backpack_neo &>/dev/null'
alias system-disable-spotlight='mv /System/Library/LaunchAgents/com.apple.Spotlight.plist /System/Library/LaunchAgents/com.apple.Spotlight.plist.BAK && mv /System/Library/LaunchDaemons/com.apple.metadata.mds.plist /System/Library/LaunchDaemons/com.apple.metadata.mds.plist.BAK'
alias system-disable-indexing='sudo mdutil -a -i off'
alias system-reset-canary='sudo rm -rf /Applications/Canary\ Mail.app && sudo rm -rf ~/Library/Containers/io.canarymail.mac/'
alias system-show-hidden-files='defaults write com.apple.finder AppleShowAllFiles YES'
alias web-browser='w3m'

function tmux-create-session() { tmux new -s $@ }
function tmux-attach-session() { tmux attach -t $@ }
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

alias npm-set-normal-registry='npm config set registry https://registry.npmjs.org/'
alias npm-set-artifatory-registry='npm config set registry https://artifactory.skyscannertools.net/artifactory/api/npm/npm/'
alias npm-upgrade-major-packages='npx npm-check-updates -u'
alias npm-upgrade-minor-packages='npx npm-check-updates -u --semverLevel major'
alias npm-upgrade-patch-packages='npx npm-check-updates -u --semverLevel minor'

# ============================================================

# ========================= CLANG =========================

alias clang-all-the-things='clang-format -i **/*.h **/*.m'

# ============================================================

alias xcode='open'
alias xcode-delete-derived-data='rm -rf ~/Library/Developer/Xcode/DerivedData/ && mkdir ~/Library/Developer/Xcode/DerivedData'
alias xcode-fix-select='sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer/'

alias AndroidStudio="open -a /Applications/Android\ Studio.app"

alias jest-run-specific-tests='npx jest BpkBannerAlert'
alias jest-fix-specific-tests='npx jest -u BpkBannerAlert'

alias redis-reset='redis-cli flushall && redis-cli flushall && redis-cli flushall && redis-cli flushall && redis-cli flushall'

alias budget='cd ~/Dropbox/Year\ Plan/2017\ -\ 2018/ && open Budgetting_new.numbers'

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
function git-jirabot-branch-name() { (echo $@ > .tmpBranchName && jirabot precommit .tmpBranchName && cat .tmpBranchName) & (sleep 2 && rm .tmpBranchName) }
alias git-rebase-use-theirs='git checkout --theirs . && git add . && git rebase --continue'
alias git-rebase-use-ours='git checkout --ours . && git add . && git rebase --continue'
alias git-gc-prune-aggressive='git gc --prune=now --aggressive && git repack'
alias git-master-latest-actual='gco master && git-fetch && git reset --hard origin/master && git pull && (git branch -D $(git-branch | grep -v "master") || true) && git submodule update && git-reset'
alias git-develop-latest-actual='gco develop && git-fetch && git reset --hard origin/develop && git pull && (git branch -D $(git-branch | grep -v "develop") || true) && git submodule update && git-reset'
alias git-master-latest=' if [[ $(pwd) == *"skyscanner-app"* ]]; then git-develop-latest-actual; else git-master-latest-actual; fi'
alias git-develop-latest='git-master-latest'
alias git-add-all-no-image-optimisation='git add .'
alias git-add-all='git-pre-push && git-add-all-no-image-optimisation && node ~/Documents/dotfiles/image-optim.js && git-add-all-no-image-optimisation'
alias git-reset='git-pre-push && git-add-all-no-image-optimisation && git reset --hard HEAD && git reset --recurse-submodules'
alias git-reset-unstaged='git checkout -- .'
alias git-fetch='git fetch --all'
alias git-rebase-master-actual='git-fetch && (git rebase origin/master | grep CONFLICT || true) && git-submodules-pull'
alias git-rebase-develop-actual='git-fetch && (git rebase origin/develop | grep CONFLICT || true) && git-submodules-pull'
alias git-rebase-master=' if [[ $(pwd) == *"skyscanner-app"* ]]; then git-rebase-develop-actual; else git-rebase-master-actual; fi'
alias git-rebase-develop='git-rebase-master'
alias git-pre-push='git status && sleep 3'
alias git-amend-push='git-pre-push && gcn! --no-verify && git-push-force'
alias git-amend-push-with-verification='git-pre-push && gcn! && git-push-force-with-verification'
alias git-test-amend-push='fixtest && git add . && gitamendpush'
alias git-push-force-with-verification='ggf && git push --set-upstream $(git remote) $(git branch | grep \* | cut -d " " -f2)'
alias git-push-force='(ggf --no-verify || true) && git push --set-upstream $(git remote) $(git branch | grep \* | cut -d " " -f2)'
alias git-yolo='git-push-force'
alias git-clear-cache='git rm -r --cached . && git add . && git commit -m && git push ~'
function git-commit-push() { git-pre-push && git commit -m "$(git-jirabot-branch-name $@)" --no-verify && git-push-force }
function git-commit-push-with-verification() { git-pre-push && git commit -m $@ && git-push-force-with-verification }
function git-make-mr() { touch remove.txt && git-add-all && git-commit-push $@ && rm remove.txt && git-add-all && git-commit-push "squash me" }
function git-rebase-i() { git rebase -i $@ }
function git-revert-to-master-actual() { git checkout origin/master $@ }
function git-revert-to-develop-actual() { git checkout origin/develop $@ }
function git-revert-to-master() {  if [[ $(pwd) == *"skyscanner-app"* ]]; then git-revert-to-develop-actual $@ ; else git-revert-to-master-actual $@ ; fi }
function git-revert-to-develop() { git-revert-to-master $@ }
function whoamip() { ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' }
alias git-clean='git clean -xdf'
alias git-move-changes-to-clean-branch='sudo rm -rf ~/Desktop/back/* && git-clean && mv ./* ~/Desktop/back/ && git-reset && git-master-latest && mv ~/Desktop/back/* ./'
alias git-empty='rm -rf * && rm .*';
alias git-pull-fork='node ~/Documents/dotfiles/pull-forked-branch.js'
alias git-submodules-init='git submodule update --init --recursive'
alias git-submodules-pull='git submodule update --recursive --remote'

alias docker-reset='docker rm $(docker ps -a -q) --force'
alias docker-reset-images='docker rmi $(docker images -q) --force'
alias docker-reset-complete='docker-reset && docker-reset-images'
alias docker-list-processes='docker ps -a'
alias docker-list-ips='docker inspect -f "{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" $(docker ps -aq)'
alias docker-list-ports='docker inspect --format="{{range $p, $conf := .NetworkSettings.Ports}} {{$p}} -> {{(index $conf 0).HostPort}} {{end}}" $(docker ps -aq)'
alias docker-start-all='docker start $(docker ps -aq)'
alias docker-pull-sql-image='docker pull microsoft/mssql-server-linux:2017-latest'

alias lightroom-delete-preview-files='find . -name "*Previews.lrdata" -exec rm -rf {} \;'

# ========================== MOZILLA =========================

alias bedrock='cd ~/Documents/bedrock/'
alias bedrock-setup='bedrock && virtualenv -p python2.7 venv && source venv/bin/activate &&  pip install -U pip && pip install -r requirements/test.txt && cp .env-dist .env &&  bin/sync-all.sh && npm i'
alias bedrock-nuke='cd ~/Documents/ && sudo rm -rf bedrock && git clone git@github.com:georgegillams/bedrock.git'
alias bedrock-nuke-setup='bedrock-nuke && bedrock-setup'
alias bedrock-run-server='bedrock && ./manage.py runserver'
alias bedrock-run-gulp='bedrock && npx gulp'
alias bedrock-localize='bedrock && ./manage.py l10n_update'
alias bedrock-test='bedrock && py.test lib bedrock'

alias mozilla-central='cd ~/Documents/mozilla-central/'
alias mozilla-central-setup='mozilla-central && ./mach build'
alias mozilla-central-run='mozilla-central && ./mach run'
alias mozilla-central-nuke='cd ~/Documents/ && sudo rm -rf mozilla-central && hg clone https://hg.mozilla.org/mozilla-central/'
alias mozilla-central-nuke-setup='mozilla-central-nuke && mozilla-central-setup'

alias activity-stream='cd ~/Documents/activity-stream/'
alias activity-stream-setup='activity-stream && touch .mozconfig && echo "" > .mozconfig && echo "ac_add_options --enable-artifact-builds" >> .mozconfig && echo "mk_add_options MOZ_OBJDIR=./objdir-frontend" >> .mozconfig && npm i && npm run buildmc'
alias activity-stream-run='activity-stream && npm run startmc'
alias activity-stream-nuke='cd ~/Documents/ && sudo rm -rf activity-stream && git clone git@github.com:georgegillams/activity-stream.git'
alias activity-stream-nuke-setup='activity-stream-nuke &&  activity-stream-setup'

# ============================================================

# ==================== PERSONAL PROJECTS =====================

alias dotfiles='cd ~/Documents/dotfiles/'
alias dotfiles-nuke='cd ~/Documents/ && sudo rm -rf dotfiles && git clone git@github.com:georgegillams/dotfiles.git'
alias dotfiles-save-tmux-conf='dotfiles && cp ~/.tmux.conf ./ && git-add-all && git-commit-push "Update TMUX conf"'
alias dotfiles-save-zshrc='dotfiles && cp ~/.zshrc ./ && git-add-all && git-commit-push "Update ZSHRC"'
alias dotfiles-save-vimrc='dotfiles && cp ~/.vimrc ./ && git-add-all && git-commit-push "Update VIMRC"'
alias dotfiles-commit-brew-script='dotfiles && git-add-all && git-commit-push "Update brew install script"'
# alias dotfiles-save-greasemonkey='dotfiles && cp ~/.vimrc ./ && git-add-all && git-commit-push "Update NVIMRC"'

alias academic-references='cd ~/Documents/react-component-academic-reference/'
alias academic-references-nuke='cd ~/Documents/ && sudo rm -rf react-component-academic-reference && git clone git@github.com:georgegillams/react-component-academic-reference.git'
alias academic-references-setup='academic-references && cd package && npm i && cd ../example && npm i && academic-references'
alias academic-references-run-web-app='academic-references && cd example && npm run start'
alias academic-references-publish='academic-references && cd package && npm publish'

alias georgegillams-old-backup='dotfiles && node georgegillams-backup.js && cd -'

alias georgegillams='cd ~/Documents/georgegillams.co.uk/'
alias georgegillams-nuke='cd ~/Documents/ && sudo rm -rf georgegillams.co.uk && git clone git@github.com:georgegillams/georgegillams.co.uk.git'
alias georgegillams-setup='georgegillams && npm i && npm run prebuild'
alias georgegillams-rebase='cd ~/Documents/react-redux && git-master-latest && georgegillams && cp -R ../react-redux/* ./'

alias ggcomponents='cd ~/Documents/gg-components/'
alias ggcomponents-nuke='cd ~/Documents/ && sudo rm -rf gg-components && git clone git@github.com:georgegillams/gg-components.git'
alias ggcomponents-setup='ggcomponents && npm i'

alias screen-reader-adventures='cd ~/Documents/screen-reader-adventures/'
alias screen-reader-adventures-nuke='cd ~/Documents/ && sudo rm -rf screen-reader-adventures && git clone git@github.com:georgegillams/screen-reader-adventures.git'
alias screen-reader-adventures-setup='screen-reader-adventures && npm i'
alias screen-reader-adventures-backup='dotfiles && node screen-reader-adventures-backup.js && cd -'

alias epicc-ticket-sales='cd ~/Documents/epicc-ticket-sales/'
alias epicc-ticket-sales-nuke='cd ~/Documents/ && sudo rm -rf epicc-ticket-sales && git clone git@github.com:georgegillams/epicc-ticket-sales.git'
alias epicc-ticket-sales-setup='epicc-ticket-sales && npm i'
alias epicc-ticket-sales-backup='dotfiles && node epicc-ticket-sales-backup.js && cd -'

# ============================================================

# ======================== SKYSCANNER ========================

alias backpack-docs='cd ~/Documents/backpack-docs/'
alias backpack-setup='backpack-docs && npm i && npm run build-backpack && git-submodules-init'
alias backpack-docs-run-tests='backpack-docs && (pkill flow | true) && npm test'
alias backpack-docs-git-submodules-reset='backpack-docs && git checkout origin/master backpack-docs-android backpack-docs-ios backpack-docs-react-native && git submodule update --init --recursive'
alias backpack-docs-watch-tests='backpack-docs && npm run jest:watch'
alias backpack-docs-run-flow='backpack-docs && (pkill flow | true) && npm run flow'
alias backpack-docs-setup='backpack-docs && npm i && npm run build-backpack && npm run submodules:pull'
alias backpack-docs-nuke='cd ~/Documents/ && sudo rm -rf backpack-docs/ && git clone --recursive git@github.com:Skyscanner/backpack-docs.git'
alias backpack-docs-nuke-setup='backpack-docs-nuke && backpack-docs-setup'
alias backpack-docs-run-docs='backpack-docs && BPK_BUILT_AT=$( date -u +%s ) npx webpack-dev-server --open'

alias backpack-publish-all-packages='backpack && cd packages && find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}' && npm publish" \;'

alias kr-disable-codesign='kr codesign off'
alias kr-enable-codesign='kr codesign on'

alias backpack='cd ~/Documents/backpack/'
alias backpack-fix-tests='backpack && find . -name "*.js.snap" -exec rm -rf {} \; && npm test'
alias backpack-run-tests='backpack && (pkill flow | true) && npm test'
alias backpack-watch-tests='backpack && npm run jest:watch'
alias backpack-release='backpack && kr-disable-codesign && npm run publish && kr-enable-codesign'
alias backpack-run-flow='backpack && (pkill flow | true) && npm run flow'
alias backpack-setup='backpack && npm i && npm run build'
alias backpack-nuke='cd ~/Documents/ && sudo rm -rf backpack/ && git clone --recursive git@github.com:Skyscanner/backpack.git'
alias backpack-nuke-setup='backpack-nuke && backpack-setup'
alias backpack-run-storybook='backpack && npm start'
alias backpack-check-cross-dependencies='backpack && node ~/Dropbox/Skyscanner/Backpack/check-bpk-dependencies.js'
alias backpack-fix-cross-dependencies='backpack && node ~/Dropbox/Skyscanner/Backpack/check-bpk-dependencies.js --fix'
alias backpack-clean-icons='sudo rm -rf packages/bpk-svgs/dist/png'
alias backpack-check-outdated-npm-packages='for dir in `ls packages`
do
  (cd ./packages/$dir && npm outdated);
done'
alias backpack-check-outdated-top-level='npm outdated'
alias backpack-output-all-outdated='backpack && (backpack-check-outdated-top-level > ~/Desktop/outdated.txt) & (sleep 5 && backpack-check-outdated-npm-packages >> ~/Desktop/outdated.txt && backpack-check-outdated-npm-packages-native >> ~/Desktop/outdated_native.txt) && cat ~/Desktop/outdated.txt | less'
alias backpack-create-pr-for-manual-update-dependencies='git-clean && backpack-setup && backpack-run-tests && gco -b no-jira-update-dependencies && git-add-all && git-commit-push "[NO-JIRA] Update dependencies"'

alias backpack-release-tokens-beta='backpack && npm run build:tokens && git-add-all && git-amend-push && (cd packages/bpk-tokens && npm publish --tag beta)'

alias backpack-rn='cd ~/Documents/backpack-react-native/'
alias backpack-rn-fix-tests='backpack-rn && find . -name "*.js.snap" -exec rm -rf {} \; && npm test'
alias backpack-rn-run-tests='backpack-rn && (pkill flow | true) && npm test'
alias backpack-rn-watch-tests='backpack-rn && npm run jest:native:watch'
alias backpack-rn-run-flow='backpack-rn && (pkill flow | true) && npm run flow'
alias backpack-rn-setup='backpack-rn && touch android/local.properties && npm i && cd ios/ && bundle exec pod repo update && bundle exec pod install --repo-update && backpack-rn'
alias backpack-rn-nuke='cd ~/Documents/ && sudo rm -rf backpack-react-native/ && git clone git@github.com:Skyscanner/backpack-react-native.git'
alias backpack-rn-nuke-setup='backpack-rn-nuke && backpack-rn-setup'
alias backpack-rn-run-android='backpack-rn && ($ANDROID_SDK_ROOT/emulator/emulator -avd NEXUS_5X_API_28 || true) & npm run android'
alias backpack-rn-run-android-old='backpack-rn && ($ANDROID_SDK_ROOT/emulator/emulator -avd NEXUS_4_API_24 || true) & npm run android'
alias backpack-rn-run-android-docs='backpack-rn && ($ANDROID_SDK_ROOT/emulator/emulator -avd NEXUS_5_API_27 || true) & npm run android'
alias backpack-rn-run-ios='backpack-rn && react-native run-ios --simulator="iPhone Xs"'
alias backpack-rn-run-ios-docs='backpack-rn && react-native run-ios --simulator="iPhone 8"'
alias backpack-rn-run-storybook='backpack-rn && npm start'
alias backpack-rn-check-cross-dependencies='backpack-rn && node ~/Dropbox/Skyscanner/Backpack/check-bpk-dependencies.js'
alias backpack-rn-fix-cross-dependencies='backpack-rn && node ~/Dropbox/Skyscanner/Backpack/check-bpk-dependencies.js --fix'

alias backpack-install-android-device='$ANDROID_SDK_ROOT/tools/bin/sdkmanager "system-images;android-24;google_apis;x86" && $ANDROID_SDK_ROOT/tools/bin/avdmanager create avd --name "bpk-avd" --package "system-images;android-24;google_apis;x86" --device "Nexus 5X"'
alias backpack-install-ruby-version='backpack && rbenv install $(cat native/ios/.ruby-version)'

alias backpack-node-sass='cd ~/Documents/backpack-node-sass/'
alias backpack-node-sass-setup='backpack-node-sass && npm i'
alias backpack-node-sass-nuke='cd ~/Documents/ && sudo rm -rf backpack-node-sass/ && git clone git@github.com:Skyscanner/backpack-node-sass.git'
alias backpack-node-sass-nuke-setup='backpack-node-sass-nuke && backpack-node-sass-setup'

alias bpk-logos='cd ~/Documents/bpk-logos/'
alias bpk-logos-setup='bpk-logos && npm i'
alias bpk-logos-nuke='cd ~/Documents/ && sudo rm -rf bpk-logos/ && git clone git@github.skyscannertools.net:backpack/bpk-logos.git'
alias bpk-logos-nuke-setup='bpk-logos-nuke && bpk-logos-setup'

alias backpack-ios='cd ~/Documents/backpack-ios/'
alias backpack-ios-setup='backpack-ios && bundle install && nvm use 8.12.0 && npm ci && (cd Example && bundle exec pod install) && npx gulp'
alias backpack-ios-open='backpack-ios && open Example/Backpack.xcworkspace'
alias backpack-ios-setup-open='backpack-ios-setup && backpack-ios-open'
alias backpack-ios-setup-open-complete='git-clean && xcode-delete-derived-data && backpack-ios-setup-open'
alias backpack-ios-nuke='cd ~/Documents/ && sudo rm -rf backpack-ios/ && git clone git@github.com:Skyscanner/backpack-ios.git'
alias backpack-ios-nuke-setup='backpack-ios-nuke && backpack-ios-setup'
alias backpack-ios-install-ruby-version='backpack-ios && rvm install ruby-$(cat .ruby-version)'
alias backpack-ios-release='backpack-ios && BUILD_SDK=iphonesimulator12.2 DESTINATION="platform=iOS Simulator,name=iPhone 8" bundle exec rake release'
alias backpack-ios-publish='backpack-ios-release'
alias backpack-ios-test='backpack-ios && BUILD_SDK=iphonesimulator12.2 DESTINATION="platform=iOS Simulator,name=iPhone 8" bundle exec rake test && Example/Pods/SwiftLint/swiftlint lint --strict'
alias backpack-ios-lint='backpack-ios && rake lint && Example/Pods/SwiftLint/swiftlint lint --strict --config Example/.swiftlint.yml'

alias backpack-android='cd ~/Documents/backpack-android/'
alias backpack-android-setup='backpack-android && npm i && npm run build'
alias backpack-android-open='backpack-android && AndroidStudio ./'
alias backpack-android-setup-open='backpack-android-setup && backpack-android-open'
alias backpack-android-nuke='cd ~/Documents/ && sudo rm -rf backpack-android/ && git clone git@github.com:Skyscanner/backpack-android.git'
alias backpack-android-nuke-setup='backpack-android-nuke && backpack-android-setup'

alias backpack-get-slack-theme='echo "Backpack Slack theme: \`#252033,#524C61,#E6E4EB,#252033,#524C61,#FFFFFF,#00D775,#FFBB00\`"'

alias fullstack='cd ~/Documents/full-stack-recruitment-test/'
alias fullstack-run='fullstack && npm run client & node server/src/server.js'
alias fullstack-setup='fullstack && npm i'
alias fullstack-nuke='cd ~/Documents/ && sudo rm -rf full-stack-recruitment-test/ && git clone git@github.com:Skyscanner/full-stack-recruitment-test.git'

alias skyscanner-ios-app='cd ~/Documents/skyscanner-app/ && npm-set-artifatory-registry'
alias skyscanner-ios-app-rn-sanity-check='skyscanner-ios-app && (cd react-native && npm run pkglock:validate && npm i && npm run lint && npm run test)'
alias skyscanner-ios-app-nuke='cd ~/Documents/ && rm -rf skyscanner-app && git clone git@github.skyscannertools.net:apps-tribe/skyscanner-app.git'
alias skyscanner-ios-app-setup='skyscanner-ios-app && gem install bundler && (cd ios && rvm use 2.6.3 && ./fullsetup) && skyscanner-ios-app'
alias skyscanner-ios-app-open='skyscanner-ios-app && open ios/Project/Working/Skyscanner.xcworkspace'
alias skyscanner-ios-app-setup-open='skyscanner-ios-app-setup && skyscanner-ios-app-open'
alias skyscanner-ios-app-login-to-npm='skyscanner-ios-app && npm login --registry https://artifactory.skyscannertools.net/artifactory/api/npm/npm/'
alias skyscanner-ios-app-update-backpack-dependency='skyscanner-ios-app && (cd ios &&  bundle exec pod update Backpack)'

alias pecha-kucha='cd ~/Dropbox/Skyscanner/Pecha\ Kucha/'
alias pecha-kucha-open='pecha-kucha && open pecha_kucha.key'

# ============================================================

export PATH=/usr/local/go/bin:/Users/georgegillams/bin:/Users/georgegillams/Library/Python/3.6/bin:$HOME/.rvm/bin:/Users/georgegillams/.rvm/gems/ruby-2.3.1/bin:/Users/georgegillams/.rvm/gems/ruby-2.3.1@global/bin:/Users/georgegillams/.rvm/rubies/ruby-2.3.1/bin:/usr/local/sbin:/Users/georgegillams/.cargo/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin:/Library/Frameworks/Mono.framework/Versions/Current/Commands:/Applications/Wireshark.app/Contents/MacOS:/Users/georgegillams/.rvm/bin:/Users/georgegillams/.vimpkg/bin

# added by travis gem
[ -f /Users/georgegillams/.travis/travis.sh ] && source /Users/georgegillams/.travis/travis.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# iTerm custom commands:
iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
  iterm2_set_user_var zshTest "test"
}

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#Auto switch nvm versions:
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
npm-set-normal-registry
add-zsh-hook chpwd load-nvmrc

