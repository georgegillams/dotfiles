export ZSH=/Users/georgegillams/.oh-my-zsh

export PATH="/usr/local/sbin:$PATH"


export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export ANDROID_HOME="$ANDROID_SDK_ROOT"
export ADMIN_USERNAME="georgegillams"
export ADMIN_PASSWORD_HASH="\$2b\$10\$kZr2lkVcPiU3wsbowjNtUOpATLlf4AZpqjSYzrM0b/G/3yj5tRt1m"

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
function zsh-remove-term-from-history() { cat ~/.zsh_history | grep -v $@ > ~/.zsh_history_updated && sleep 2 && cp ~/.zsh_history_updated ~/.zsh_history && rm ~/.zsh_history_updated }
alias zsh-rebuild='dotfiles-save-zshrc && cd - && . ~/.zshrc'
alias vim-rebuild='vim +"source ~/.vimrc" +PluginInstall +qall && dotfiles-save-vimrc && cd -'
alias zsh-edit-config='vim ~/.zshrc'
alias brew-test-install-script='dotfiles && cp ./brew_install.sh ~/Desktop/ && cd .. && rm -rf dotfiles && rm -rf ~/.ssh/* && cd ~/Desktop && ./brew_install.sh'
alias brew-edit-install-script='vim ~/Documents/dotfiles/brew_install.sh'
function brew-install() { dotfiles && echo "\nbrew install $@" >> brew_install.sh && git-add-all && git-commit-push "Update brew script" && cd - && brew install $@ }
function brew-cask-install() { dotfiles && echo "\nbrew cask install $@" >> brew_install.sh && git-add-all && git-commit-push "Update brew script" && cd - && brew cask install $@ }
alias zsh-pull-configs='cp ~/Dropbox/Apps/ZSH/.zshrc ~/.zshrc && cp ~/Dropbox/Apps/NeoVim/.vimrc ~/.vimrc'
alias atom-link-synced-settings='ln -s ~/Dropbox/Apps/Atom ~/.atom'
alias dropbox-link-synced-settings='ln -s /Users/georgegillams/Dropbox/Desktop ./Desktop'
alias dropbox='cd ~/Dropbox'
alias documents='cd ~/Documents'
alias desktop='cd ~/Desktop'
alias gradle-clear-cache='rm -rf $HOME/.gradle/caches/'

alias weather-southampton='curl wttr.in/Southampton'
alias weather-london='curl wttr.in/London'
alias weather='weather-london';

alias vim-edit-config='vim ~/.vimrc'

alias system-remove-nvm='sudo rm -rf /usr/local/bin/npm /usr/local/share/man/man1/node* /usr/local/lib/dtrace/node.d ~/.npm ~/.node-gyp /opt/local/bin/node opt/local/include/node /opt/local/lib/node_modules && brew uninstall nvm && rm -f /usr/local/bin/npm /usr/local/lib/dtrace/node.d && sudo rm -rf ~/.npm && sudo rm -rf ~/.nvm &&  rm -f /usr/local/bin/node'
alias system-fix-vimrc-location="mkdir -p ~/.config/vim && echo 'source ~/.vimrc' > ~/.config/vim/init.vim"
alias system-fix-spotlight='sudo mdutil -E'
alias system-fix-ssh='ssh-add ~/.ssh/id_rsa &>/dev/null'
alias system-fix-ssh-neo='ssh-add ~/.ssh/id_rsa_backpack_neo &>/dev/null'
alias system-disable-spotlight='mv /System/Library/LaunchAgents/com.apple.Spotlight.plist /System/Library/LaunchAgents/com.apple.Spotlight.plist.BAK && mv /System/Library/LaunchDaemons/com.apple.metadata.mds.plist /System/Library/LaunchDaemons/com.apple.metadata.mds.plist.BAK'
alias system-disable-indexing='sudo mdutil -a -i off'
alias system-reset-canary='sudo rm -rf /Applications/Canary\ Mail.app && sudo rm -rf ~/Library/Containers/io.canarymail.mac/'
alias system-show-hidden-files='defaults write com.apple.finder AppleShowAllFiles YES'
alias web_browser='w3m'
alias fiddler='cd /Applications/fiddler/ && mono --arch=32 Fiddler.exe'

alias dotfiles='cd ~/Documents/dotfiles/'
alias dotfiles-nuke='cd ~/Documents/ && sudo rm -rf dotfiles && git clone git@github.com:georgegillams/dotfiles.git'
alias dotfiles-save-zshrc='dotfiles && cp ~/.zshrc ./ && git-add-all && git-commit-push "Update ZSHRC"'
alias dotfiles-save-vimrc='dotfiles && cp ~/.vimrc ./ && git-add-all && git-commit-push "Update VIMRC"'
alias dotfiles-commit-brew-script='dotfiles && git-add-all && git-commit-push "Update brew install script"'
# alias dotfiles-save-greasemonkey='dotfiles && cp ~/.vimrc ./ && git-add-all && git-commit-push "Update NVIMRC"'

alias android-shake='$ANDROID_SDK_ROOT/platform-tools/adb shell input keyevent 82'

alias npm-check-unused-dependencies='npm install depcheck -g && depcheck'

# ============================================================

alias xcode='open'
alias xcode-delete-derived-data='sudo rm -rf ~/Library/Developer/Xcode/DerivedData/ && mkdir ~/Library/Developer/Xcode/DerivedData'
alias xcode-fix-select='sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer/'

alias AndroidStudio="open -a /Applications/Android\ Studio.app"

alias jest-run-specific-tests='npx jest BpkBannerAlert'
alias jest-fix-specific-tests='npx jest -u BpkBannerAlert'

alias redis-reset='redis-cli flushall && redis-cli flushall && redis-cli flushall && redis-cli flushall && redis-cli flushall'

alias work-plan='cd ~/Dropbox/Southampton/WORK/8\ Semester && open WORK_PLAN.numbers'

alias house='cd ~/Dropbox/Mortgage\ and\ House/'
alias budget='cd ~/Dropbox/Year\ Plan/2017\ -\ 2018/ && open Budgetting.numbers'
alias wedding=' cd ~/Dropbox/Wedding/'
alias wedding_budget='wedding && open Wedding_Expenses.xlsx'

alias clearcache='npm cache clean --force && npm cache clear && watchman watch-del-all && sudo rm -rf $TMPDIR/react-* && sudo rm -rf node_modules/'

alias get-email-old='echo "georgegillams@hotmail.co.uk" | pbcopy'
alias get-email='echo "g@georgegillams.co.uk" | pbcopy'
alias get-email-work='echo "george.gillams@skyscanner.net" | pbcopy'
alias get-phone='echo "+447867592615" | pbcopy'
alias get-phone-local='echo "07867592615" | pbcopy'

function gif-make-loop-forever() { convert -delay 5 -loop 0 $@ $@ }

alias travis-fold-start='echo -e "travis_fold:start:$1\033[33;1m$2\033[0m"'
alias travis-fold-end='echo -e "\ntravis_fold:end:$1\r"'

alias git-branch='git branch'
alias git-show-me-how-to-view-a-forked-branch='echo "gco -b username-branch-name master\ngit pull https://github.com/username/backpack.git branch-name"'
alias git-show-me-how-to-unfold-all-gh-comments='echo "const toClick = document.getElementsByClassName(\"btn-link text-gray float-right f6 outdated-comment-label show-outdated-button js-details-target\");
for (let i = 0; i < toClick.length; i += 1){
toClick[i].click();
}"'
alias git-master-latest='gco master && git-fetch && git reset --hard origin/master && git pull && git branch -D $(git-branch | grep -v "master")'
alias git-develop-latest='gco develop && git-fetch && git reset --hard origin/develop && git pull && git branch -D $(git-branch | grep -v "develop")'
alias git-add-all='git add .'
alias git-reset='git-add-all && git reset --hard HEAD'
alias git-fetch='git fetch --all'
alias git-rebase-master='git fetch --all && git rebase origin/master | grep CONFLICT'
alias git-pre-push='git status && sleep 3'
alias git-amend-push='git-pre-push && gcn! && ggf'
alias git-amend-push-no-verify='git-pre-push && gcn! --no-verify && ggf'
alias git-test-amend-push='fixtest && git add . && gitamendpush'
alias git-push-force='ggf'
alias git-yolo='git-push-force'
alias git-clear-cache='git rm -r --cached . && git add . && git commit -m && git push ~'
function git-commit-push() { git-pre-push && git commit -m $@ && ggf }
function git-commit-push-no-verify() { git-pre-push && git commit -m $@ --no-verify && ggf }
function git-make-mr() { touch remove.txt && git-add-all && git-commit-push $@ && rm remove.txt && git-add-all && git-commit-push "squash me" }
function git-rebase-i() { git rebase -i $@ }
function git-revert-to-master() { git checkout origin/master $@ }
alias git-rebase-continue='git rebase --continue'
alias git-rebase-abort='git rebase --abort'
alias git-clean='git clean -xdf'
alias git-move-changes-to-clean-branch='sudo rm -rf ~/Desktop/back/* && git-clean && mv ./* ~/Desktop/back/ && git-reset && git-master-latest && mv ~/Desktop/back/* ./'
alias git-empty='rm -rf * && rm .*';
alias git-pull-fork='node ~/Documents/dotfiles/pull-forked-branch.js'
alias git-submodules-init='git submodule update --init --recursive'

alias docker-reset='docker rm $(docker ps -a -q) --force'
alias docker-reset-images='docker rmi $(docker images -q) --force'
alias docker-reset-complete='docker-reset && docker-reset-images'
alias docker-list-processes='docker ps -a'
alias docker-list-ips='docker inspect -f "{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" $(docker ps -aq)'
alias docker-list-ports='docker inspect --format="{{range $p, $conf := .NetworkSettings.Ports}} {{$p}} -> {{(index $conf 0).HostPort}} {{end}}" $(docker ps -aq)'
alias docker-start-all='docker start $(docker ps -aq)'
alias docker-pull-sql-image='docker pull microsoft/mssql-server-linux:2017-latest'

alias bedrock='cd ~/Documents/bedrock/'
alias bedrock-setup='bedrock && virtualenv -p python2.7 venv && source venv/bin/activate &&  pip install -U pip && pip install -r requirements/test.txt && cp .env-dist .env &&  bin/sync-all.sh && yarn'
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


# ==================== PERSONAL PROJECTS =====================

alias academic-references='cd ~/Documents/react-component-academic-reference/'
alias academic-references-nuke='cd ~/Documents/ && sudo rm -rf react-component-academic-reference && git clone git@github.com:georgegillams/react-component-academic-reference.git'
alias academic-references-setup='academic-references && cd package && npm i && cd ../example && npm i && academic-references'
alias academic-references-run-web-app='academic-references && cd example && npm run start'
alias academic-references-publish='academic-references && cd package && npm publish'

alias georgegillams='cd ~/Documents/georgegillams.co.uk/'
alias georgegillams-nuke='georgegillams && cd .. && rm -rf georgegillams.co.uk && git clone git@github.com:georgegillams/georgegillams.co.uk.git'
alias georgegillams-lint-fix='georgegillams && npx eslint --fix src/*/*/*.js* && npx eslint --fix src/*/*.js* && npx eslint --fix src/*.js*'
alias glint='(georgegillams-lint-fix || true)'
alias georgegillams-backup='dotfiles && node georgegillams-backup.js && cd -'

alias georgegillams-depreciated='cd ~/Documents/georgegillams-depreciated/'
alias georgegillams-depreciated-nuke='cd ~/Documents/ && sudo rm -rf georgegillams-depreciated && git clone git@github.com:georgegillams/georgegillams-depreciated.git'
alias georgegillams-depreciated-setup='georgegillams-depreciated && npm i'
alias georgegillams-depreciated-run-web-app='georgegillams-depreciated && npm run start:client'
alias georgegillams-depreciated-run-server='georgegillams-depreciated && npm run start:server'
alias georgegillams-depreciated-run-all='redis-server & georgegillams-depreciated && npm run start'
alias georgegillams-depreciated-backup='dotfiles && node georgegillams-depreciated-backup.js && cd -'

alias epicc-conference='cd ~/Documents/epicc-conference/'
alias epicc-conference-nuke='cd ~/Documents/ && sudo rm -rf epicc-conference && git clone git@github.com:epicc-conference/epicc-conference.git'
alias epicc-conference-setup='epicc-conference && npm i'
alias epicc-conference-run-web-app='epicc-conference && npm run start:client'
alias epicc-conference-run-server='epicc-conference && npm run start:server'
alias epicc-conference-run-all='epicc-conference && npm run start'
alias epicc-conference-backup='dotfiles && node epicc-conference-backup.js && cd -'

# ============================================================

# ======================== SKYSCANNER ========================

alias backpack='cd ~/Documents/backpack/'
alias backpack-fix-tests='backpack && find . -name "*.js.snap" -delete && npm test'
alias backpack-run-tests='backpack && (pkill flow | true) && npm test'
alias backpack-watch-tests='backpack && npm run jest:native:watch & npm run jest:watch'
alias backpack-run-flow='backpack && (pkill flow | true) && npm run flow'
alias backpack-setup='backpack && touch native/android/local.properties && npm i && npm run build && npm run bootstrap && npm run build && cd native/ios/ && bundle install && bundle exec pod install && backpack'
alias backpack-nuke='cd ~/Documents/ && sudo rm -rf backpack/ && git clone git@github.com:Skyscanner/backpack.git'
alias backpack-nuke-setup='backpack-nuke && backpack-setup'
alias backpack-run-native='backpack && npm run native'
alias backpack-run-android='backpack && npm run android'
alias backpack-run-ios='backpack && npm run ios'
alias backpack-run-docs='backpack && npm run docs'
alias backpack-run-storybook='backpack && npm start'
alias backpack-check-cross-dependencies='backpack && npm run check-bpk-dependencies'
alias backpack-fix-cross-dependencies='backpack && npm run fix-bpk-dependencies'
alias backpack-clean-icons='sudo rm -rf packages/bpk-svgs/dist/png'
alias backpack-check-outdated-npm-packages='for dir in `ls packages`
do
  (cd ./packages/$dir && npm outdated);
done'
alias backpack-check-outdated-npm-packages-native='for dir in `ls native/packages`
do
  (cd ./native/packages/$dir && npm outdated);
done'
alias backpack-check-outdated-top-level='npm outdated'
alias backpack-output-all-outdated='backpack && (backpack-check-outdated-top-level > ~/Desktop/outdated.txt) & (sleep 5 && backpack-check-outdated-npm-packages >> ~/Desktop/outdated.txt && backpack-check-outdated-npm-packages-native >> ~/Desktop/outdated_native.txt) && cat ~/Desktop/outdated.txt | less'
alias backpack-create-pr-for-manual-update-dependencies='git-clean && backpack-setup && backpack-run-tests && gco -b no-jira-update-dependencies && git-add-all && git-commit-push "[NO-JIRA] Update dependencies"'

alias backpack-install-android-device='$ANDROID_SDK_ROOT/tools/bin/sdkmanager "system-images;android-24;google_apis;x86" && $ANDROID_SDK_ROOT/tools/bin/avdmanager create avd --name "bpk-avd" --package "system-images;android-24;google_apis;x86" --device "Nexus 5X"'
alias backpack-install-ruby-version='backpack && rbenv install $(cat native/ios/.ruby-version)'

alias backpack-ios='cd ~/Documents/backpack-ios/'
alias backpack-ios-setup='backpack-ios && bundle install && npm i && (cd Example && bundle exec pod install) && npx gulp'
alias backpack-ios-open='backpack-ios && open Example/Backpack.xcworkspace'
alias backpack-ios-setup-open='backpack-ios-setup && backpack-ios-open'
alias backpack-ios-nuke='cd ~/Documents/ && sudo rm -rf backpack-ios/ && git clone git@github.com:Skyscanner/backpack-ios.git'
alias backpack-ios-nuke-setup='backpack-ios-nuke && backpack-ios-setup'
alias backpack-ios-install-ruby-version='backpack-ios && rvm install ruby-$(cat .ruby-version)'
alias backpack-ios-release='backpack-ios && BUILD_SDK=iphonesimulator12.0 DESTINATION="platform=iOS Simulator,name=iPhone 8" bundle exec rake release'

alias backpack-android='cd ~/Documents/backpack-android/'
alias backpack-android-setup='backpack-android && npm i'
alias backpack-android-open='backpack-android && AndroidStudio ./'
alias backpack-android-setup-open='backpack-android-setup && backpack-android-open'
alias backpack-android-nuke='cd ~/Documents/ && sudo rm -rf backpack-android/ && git clone git@github.com:Skyscanner/backpack-android.git'
alias backpack-android-nuke-setup='backpack-android-nuke && backpack-android-setup'

alias backpack-get-slack-theme='echo "Backpack Slack theme: \`#252033,#524C61,#E6E4EB,#252033,#524C61,#FFFFFF,#00D775,#FFBB00\`"'

alias fullstack='cd ~/Documents/full-stack-recruitment-test/'
alias fullstack-run='fullstack && npm run client & node server/src/server.js'
alias fullstack-setup='fullstack && npm i'
alias fullstack-nuke='cd ~/Documents/ && sudo rm -rf full-stack-recruitment-test/ && git clone git@github.com:Skyscanner/full-stack-recruitment-test.git'

alias skyscanner-ios-app='cd ~/Documents/skyscanner-app/'
alias skyscanner-ios-app-nuke='cd ~/Documents/ && rm -rf skyscanner-app && git clone git@github.skyscannertools.net:apps-tribe/skyscanner-app.git'
alias skyscanner-ios-app-setup='skyscanner-ios-app && gem install bundler && cd ios && rvm use 2.3.1 && ./fullsetup'
alias skyscanner-ios-app-open='skyscanner-ios-app && open Project/Working/Skyscanner.xcworkspace'
alias skyscanner-ios-app-setup-open='skyscanner-ios-app-setup && skyscanner-ios-app-open'

alias pecha-kucha='cd ~/Dropbox/Skyscanner/Pecha\ Kucha/'
alias pecha-kucha-open='pecha-kucha && open pecha_kucha.key'

# ============================================================

export PATH=/Users/georgegillams/bin:/Users/georgegillams/Library/Python/3.6/bin:$HOME/.rvm/bin:/Users/georgegillams/.rvm/gems/ruby-2.3.1/bin:/Users/georgegillams/.rvm/gems/ruby-2.3.1@global/bin:/Users/georgegillams/.rvm/rubies/ruby-2.3.1/bin:/usr/local/sbin:/Users/georgegillams/.cargo/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin:/Library/Frameworks/Mono.framework/Versions/Current/Commands:/Applications/Wireshark.app/Contents/MacOS:/Users/georgegillams/.rvm/bin:/Users/georgegillams/.vimpkg/bin

# added by travis gem
[ -f /Users/georgegillams/.travis/travis.sh ] && source /Users/georgegillams/.travis/travis.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# export NVM_DIR=~/.nvm
# source $(brew --prefix nvm)/nvm.sh
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
