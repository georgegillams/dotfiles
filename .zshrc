export ZSH=/Users/georgegillams/.oh-my-zsh

export PATH="/usr/local/sbin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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
  export EDITOR='mvim'
fi

# set -o vi

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

alias weather-southampton='curl wttr.in/Southampton'
alias weather-london='curl wttr.in/London'
alias weather='weather-london';

alias vim-edit-config='vim ~/.vimrc'

alias system-fix-nvm='sudo rm -rf /usr/local/bin/npm /usr/local/share/man/man1/node* /usr/local/lib/dtrace/node.d ~/.npm ~/.node-gyp /opt/local/bin/node opt/local/include/node /opt/local/lib/node_modules && brew uninstall nvm && rm -f /usr/local/bin/npm /usr/local/lib/dtrace/node.d && sudo rm -rf ~/.npm && sudo rm -rf ~/.nvm &&  rm -f /usr/local/bin/node'
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

alias xcode='open'
alias xcode-delete-derived-data='sudo rm -rf ~/Library/Developer/Xcode/DerivedData/ && mkdir ~/Library/Developer/Xcode/DerivedData'
alias xcode-fix-select='sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer/'

alias redis-reset='redis-cli flushall && redis-cli flushall && redis-cli flushall && redis-cli flushall && redis-cli flushall'

alias work-plan='cd ~/Dropbox/Southampton/WORK/8\ Semester && open WORK_PLAN.numbers'

alias budget='cd ~/Dropbox/Year\ Plan/2017\ -\ 2018/ && open Budgetting.numbers'
alias wedding=' cd ~/Dropbox/Wedding/'
alias wedding_budget='wedding && open Wedding_Expenses.xlsx'

alias clearcache='npm cache clean --force && npm cache clear && watchman watch-del-all && sudo rm -rf $TMPDIR/react-* && sudo rm -rf node_modules/'

alias getemail='echo "georgegillams@hotmail.co.uk" | pbcopy'
alias getemailwork='echo "george.gillams@skyscanner.net" | pbcopy'
alias getphone='echo "+447867592615" | pbcopy'
alias getphonelocal='echo "07867592615" | pbcopy'

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
alias git-amend-push='gcn! && ggf'
alias git-amend-push-no-verify='gcn! --no-verify && ggf'
alias git-test-amend-push='fixtest && git add . && gitamendpush'
alias git-push-force='ggf'
alias git-yolo='git-push-force'
alias git-clear-cache='git rm -r --cached . && git add . && git commit -m && git push ~'
function git-commit-push() { git commit -m $@ && ggf }
function git-commit-push-no-verify() { git commit -m $@ --no-verify && ggf }
function git-make-mr() { touch remove.txt && git-add-all && git-commit-push $@ && rm remove.txt && git-add-all && git-commit-push "squash me" }
function git-rebase-i() { git rebase -i $@ }
function git-revert-to-master() { git checkout origin/master $@ }
alias git-rebase-continue='git rebase --continue'
alias git-rebase-abort='git rebase --abort'
alias git-clean='git clean -xdf'
alias git-move-changes-to-clean-branch='sudo rm -rf ~/Desktop/back/* && git-clean && mv ./* ~/Desktop/back/ && git-reset && git-master-latest && mv ~/Desktop/back/* ./'
alias git-empty='rm -rf * && rm .*';

alias bedrock='cd ~/Documents/bedrock/'
alias bedrock-setup='bedrock && virtualenv -p python2.7 venv && source venv/bin/activate &&  pip install -U pip && pip install -r requirements/test.txt && cp .env-dist .env &&  bin/sync-all.sh && yarn'
alias bedrock-nuke='cd ~/Documents/ && sudo rm -rf bedrock && git clone git@github.com:georgegillams/bedrock.git'
alias bedrock-nuke-setup='bedrock-nuke && bedrock-setup'
alias bedrock-run-server='bedrock && ./manage.py runserver'
alias bedrock-run-gulp='bedrock && gulp'
alias bedrock-localize='bedrock && ./manage.py l10n_update'
alias bedrock-test='bedrock && py.test lib bedrock'

alias mozilla-central='cd ~/Documents/mozilla-central/'
alias mozilla-central-setup='mozilla-central && ./mach build'
alias mozilla-central-run='mozilla-central && ./mach run'
alias mozilla-central-nuke='cd ~/Documents/ && sudo rm -rf mozilla-central && hg clone https://hg.mozilla.org/mozilla-central/'
alias mozilla-central-nuke-setup='mozilla-central-nuke && mozilla-central-setup'

alias activity-stream='cd ~/Documents/activity-stream/'
alias activity-stream-setup='activity-stream && touch .mozconfig && echo "" > .mozconfig && echo "ac_add_options --enable-artifact-builds" >> .mozconfig && echo "mk_add_options MOZ_OBJDIR=./objdir-frontend" >> .mozconfig && npm ci && npm run buildmc'
alias activity-stream-run='activity-stream && npm run startmc'
alias activity-stream-nuke='cd ~/Documents/ && sudo rm -rf activity-stream && git clone git@github.com:georgegillams/activity-stream.git'
alias activity-stream-nuke-setup='activity-stream-nuke &&  activity-stream-setup'

alias dotfiles='cd ~/Documents/dotfiles/'
alias dotfiles-nuke='cd ~/Documents/ && sudo rm -rf dotfiles && git clone git@github.com:georgegillams/dotfiles.git'
alias dotfiles-save-zshrc='dotfiles && cp ~/.zshrc ./ && git-add-all && git-commit-push "Update ZSHRC"'
alias dotfiles-save-vimrc='dotfiles && cp ~/.vimrc ./ && git-add-all && git-commit-push "Update VIMRC"'
alias dotfiles-commit-brew-script='dotfiles && git-add-all && git-commit-push "Update brew install script"'
# alias dotfiles-save-greasemonkey='dotfiles && cp ~/.vimrc ./ && git-add-all && git-commit-push "Update NVIMRC"'

alias academic-references='cd ~/Documents/react-component-academic-reference/'
alias academic-references-nuke='cd ~/Documents/ && sudo rm -rf react-component-academic-reference && git clone git@github.com:georgegillams/react-component-academic-reference.git'
alias academic-references-setup='academic-references && cd package && npm ci && cd ../example && npm ci && academic-references'
alias academic-references-run-web-app='academic-references && cd example && npm run start'
alias academic-references-publish='academic-references && cd package && npm publish'

alias georgegillams-ssr-2-lint-fix='georgegillams-ssr-2 && npx eslint --fix src/*/*/*.js* && npx eslint --fix src/*/*.js* && npx eslint --fix src/*.js*'
alias glint='(georgegillams-ssr-2-lint-fix || true)'
alias georgegillams='cd ~/Documents/georgegillams.co.uk/'
alias georgegillams-ssr-2='cd ~/Documents/georgegillams_ssr_2/'
alias georgegillams-ssr-2-nuk='georgegillams-ssr-2 && cd .. && rm -rf georgegillams_ssr_2 && git clone git@github.com:georgegillams/georgegillams_ssr_2.git'
alias georgegillams-nuke='cd ~/Documents/ && sudo rm -rf georgegillams && git clone git@github.com:georgegillams/georgegillams.co.uk.git'
alias georgegillams-setup='georgegillams && npm ci'
alias georgegillams-run-web-app='georgegillams && npm run start:client'
alias georgegillams-run-server='georgegillams && npm run start:server'
alias georgegillams-run-all='redis-server & georgegillams && npm run start'
alias georgegillams-backup='dotfiles && node georgegillams.co.uk-backup.js && cd -'

alias epicc-conference='cd ~/Documents/epicc-conference/'
alias epicc-conference-nuke='cd ~/Documents/ && sudo rm -rf epicc-conference && git clone git@github.com:epicc-conference/epicc-conference.git'
alias epicc-conference-setup='epicc-conference && npm ci'
alias epicc-conference-run-web-app='epicc-conference && npm run start:client'
alias epicc-conference-run-server='epicc-conference && npm run start:server'
alias epicc-conference-run-all='epicc-conference && npm run start'

alias backpack='cd ~/Documents/backpack/'
alias backpack-fix-tests='backpack && find . -name "*.js.snap" -delete && npm test'
alias backpack-run-tests='backpack && npm test'
alias backpack-watch-tests='backpack && npm run jest:native:watch & npm run jest:watch'
alias backpack-run-flow='backpack && npm run flow'
alias backpack-fix-tests-web='backpack && find . -name "*.js.snap" -not -path "./native/*" -delete && npm run test'
alias backpack-run-tests-web='backpack && npm run test'
alias backpack-fix-tests-native='backpack && cd native/ && find . -name "*.js.snap" -delete && cd .. && npm run test:native'
alias backpack-run-tests-native='backpack && npm run test:native'
alias backpack-setup='backpack && touch native/android/local.properties && npm ci && npm run build && npm run bootstrap && npm run build && cd native/ios/ && bundle install && bundle exec pod install && backpack'
alias backpack-nuke='cd ~/Documents/ && sudo rm -rf backpack/ && git clone git@github.com:Skyscanner/backpack.git'
alias backpack-nuke-setup='backpack-nuke && backpack-setup'
alias backpack-refresh-android-device='$ANDROID_SDK_ROOT/tools/bin/sdkmanager "system-images;android-24;google_apis;x86" && $ANDROID_SDK_ROOT/tools/bin/avdmanager create avd --name "bpk-avd" --package "system-images;android-24;google_apis;x86" --device "Nexus 5X"'
alias backpack-run-native='backpack && npm run native'
alias backpack-run-android='backpack && npm run android'
alias backpack-run-ios='backpack && npm run ios'
alias backpack-run-emulators='backpack && backpack-run-ios && backpack-run-android'
alias backpack-detox-ios='backpack && npm run detox:build:ios'
alias backpack-detox-android='backpack && npm run detox:build:android'
alias backpack-run-docs='backpack && npm run docs'
alias backpack-run-docs-neo='backpack && npm run docs'
alias backpack-compile-docs='backpack && npm ci && npm run build && npm run docs:dist'
alias backpack-run-storybook='backpack && npm start'
alias backpack-move-changes-to-clean-branch='backpack && sudo rm -rf ~/Desktop/back/* && mv native packages changelog.md readme.md ~/Desktop/back/ && git-master-latest && sudo rm -rf native && sudo rm -rf packages && mv ~/Desktop/back/native ~/Desktop/back/packages ./'
alias backpack-check-cross-dependencies='backpack && npm run check-bpk-dependencies'
alias backpack-generate-prop-tables='backpack && npm run generate-prop-tables'
alias backpack-update-prop-geneeration-PR='backpack &&  git add scripts/npm/generate-prop-tables.js && git commit --amend --no-edit --no-verify  && git-reset'
alias backpack-fix-cross-dependencies='backpack && npm run fix-bpk-dependencies'
alias backpack-replace-binds='backpack && npm run replace-binds'
function backpack-git-test-commit-push() { backpack && backpack-fix-tests= && git add . && git commit -m $@ && ggf }
alias backpack-android-shake='$ANDROID_SDK_ROOT/platform-tools/adb shell input keyevent 82'
alias backpack-delete-icons='sudo rm -rf packages/bpk-svgs/dist/png'

alias backpack-install-ruby-version='backpack && rbenv install $(cat native/ios/.ruby-version)'

alias backpack-get-slack-theme='echo "Backpack Slack theme: \`#252033,#524C61,#E6E4EB,#252033,#524C61,#FFFFFF,#00D775,#FFBB00\`"'

alias fullstack='cd ~/Documents/full-stack-recruitment-test/'
alias fullstack-run='fullstack && npm run client & APIKEY="ASDF" node server/src/server.js'
alias fullstack-setup='fullstack && npm ci'
alias fullstack-nuke='cd ~/Documents/ && sudo rm -rf full-stack-recruitment-test/ && git clone git@github.com:Skyscanner/full-stack-recruitment-test.git'

alias skyscanner-ios-app-setup='skyscanner-ios-app./dependencies repo update && ./dependencies install'
alias skyscanner-ios-app-run='cd ~/Documents/skyscanner-ios-app/'
alias skyscanner-android-app-run='cd ~/Documents/android-app/'

alias docker-reset='docker rm $(docker ps -a -q) --force'
alias docker-reset-images='docker rmi $(docker images -q) --force'
alias docker-reset-complete='docker-reset && docker-reset-images'
alias docker-list-processes='docker ps -a'
alias docker-list-ips='docker inspect -f "{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" $(docker ps -aq)'
alias docker-list-ports='docker inspect --format="{{range $p, $conf := .NetworkSettings.Ports}} {{$p}} -> {{(index $conf 0).HostPort}} {{end}}" $(docker ps -aq)'
alias docker-start-all='docker start $(docker ps -aq)'
alias docker-pull-sql-image='docker pull microsoft/mssql-server-linux:2017-latest'

# ======================== UNIVERSITY ========================
alias acg='cd ~/Documents/automated-code-generation-2'
alias acg-nuke='cd ~/Documents/ && sudo rm -rf automated-code-generation-2 && git clone git@github.com:georgegillams/automated-code-generation-2.git'
alias acg-compile-and-run='c++ *.c *.h && clear && ./a.out'
# alias acg-setup='acg && pipenv install'
# alias acg-run='acg && pipenv run python3 demo'
# alias acg-run-initial-plots='acg && pipenv run python3 initial_graph_plots'
# alias acg-test='acg && pytest tests'

alias dmp='cd ~/Documents/data-mining-personal'
alias dmp-nuke='cd ~/Documents/ && sudo rm -rf data-mining-personal && git clone git@github.com:georgegillams/data-mining-personal.git'
alias dmp-setup='dmp && pipenv install'
alias dmp-run-data-cleanup='dmp && pipenv run python3 data_cleaning'
alias dmp-run-data-clustering='dmp && pipenv run python3 data_clustering'
alias dmp-run-data-matrix='dmp && pipenv run python3 data_matrix_generation'
alias dmp-run-data-mds='dmp && pipenv run python3 data_multidimensional_scaling'
alias dmp-run-all='dmp-run-data-cleanup && dmp-run-data-clustering && dmp-run-data-matrix && dmp-run-data-mds'
alias dmp-test='dmp && pytest tests'

alias start-vowl='cd ~/Downloads/webvowl_1.0.6 && http-server ./ & open  http://127.0.0.1:8080'
alias semantic-web='cd ~/Dropbox/Southampton/WORK/8\ Semester/15\ -\ Semantic\ Web\ Technologies/'
alias semantic-web-coursework='cd ~/Dropbox/Southampton/WORK/8\ Semester/15\ -\ Semantic\ Web\ Technologies/coursework/ && open Specification.pdf && open Relationships.numbers && open tv-listing-ontology.owl'
alias semantic-web-upload-ontology='georgegillams && cp ~/Dropbox/Southampton/WORK/8\ Semester/15\ -\ Semantic\ Web\ Technologies/coursework/tv-listing-ontology.owl ./server_content/ontologies/tv-listing-ontology.owl && git-add-all && git-commit-push "Update tv-listing ontology" && cd -'
alias automated-code-generation='cd ~/Dropbox/Southampton/WORK/8\ Semester/09\ -\ Automated\ Code\ Generation/'
alias data-mining='cd ~/Dropbox/Southampton/WORK/8\ Semester/37\ -\ Data\ Mining/'

alias gdp='cd ~/Documents/gdp3/'
alias gdp-copy-message-structures-to-client='gdp && cp *message_structure.json ./client/src/'
alias gdp-nuke='cd ~/Documents/ && sudo rm -rf gdp3 && git clone git@github.com:georgegillams/gdp3.git'
alias gdp-nuke-setup='gdp-nuke && gdp-setup'
alias gdp-run-tests='gdp && jest'
alias gdp-install-server='cd ~/Desktop/spi/ && npm ci -g node-sass && npm ci -g react &&npm ci -g eslint &&  npm ci -g eslint-plugin-babel &&  -g node-es ci6 &m&  p-g nrpio -- cibuimld-pfronm-so ciurcme &p& 'n
alias gdp-uninstall-server='cd ~/Desktop/ && sudo rm -rf spi && npm uninstall -g rpio && sudo rm -rf /home/pi/Desktop/spi/node_modules/rpio/'
alias gdp-fix-tests='gdp && find . -name "*.js.snap" -delete && gdp-run-tests'
alias gdp-setup='gdp && npm ci && gdp-copy-message-structures-to-client'
alias gdp-run-web-app='gdp && gdp-copy-message-structures-to-client && cd client && heroku local web'
alias gdp-run-rpi='gdp && npm run start:rpi'
alias gdp-run-all='gdp && gdp-copy-message-structures-to-client && npm run start'
alias gdp-run-server='gdp && gdp-copy-message-structures-to-client && cd spi_server && ./build.sh && ./build/spi_server_app'
alias gdp-send-rust-files-to-pi-eth0='gdp && cp *message_structure.json ./spi_server_rs/ && cp *message_structure.json ./spi_server_rs/src/ && cd spi_server_rs && rsync --recursive --exclude="node_modules" --exclude="target" -v -e ssh ./ pi@192.168.2.3:/home/pi/Desktop/spi_server_rs/ && gdp && rm -rf ./spi_server_rs/*message_structure.json && rm -rf ./spi_server_rs/src/*message_structure.json'
alias gdp-send-rust-files-to-pi-eth0-home='gdp && cp *message_structure.json ./spi_server_rs/ && cp *message_structure.json ./spi_server_rs/src/ && cd spi_server_rs && rsync --recursive --exclude="node_modules" --exclude="target" -v -e ssh ./ pi@192.168.2.2:/home/pi/Desktop/spi_server_rs/ && gdp && rm -rf ./spi_server_rs/*message_structure.json && rm -rf ./spi_server_rs/src/*message_structure.json'
# alias gdp-send-rust-files-to-pi-eth0-iphone='gdp && cd spi_server_rs && rsync --recursive --exclude="node_modules" --exclude="target" -v -e ssh ./ pi@172.20.10.7:/home/pi/Desktop/spi_server_rs/'
alias gdp-ssh-pi-eth0='ssh pi@192.168.2.3'
alias gdp-ssh-pi-eth0-home='ssh pi@192.168.2.2'
# alias gdp-ssh-pi-eth0-iphone='ssh pi@172.20.10.7'
alias gdp-writeup='cd ~/Dropbox/Southampton/WORK/Group\ Design\ Project/ && open Report.docx'
alias gdp-message-structure='cd ~/Dropbox/Southampton/WORK/Group\ Design\ Project/communication-specification/ && open messages.numbers'
alias gdp-individual-report='cd ~/Dropbox/Southampton/WORK/Group\ Design\ Project/individual\ report && open ProjectReport.tex && open Specification.pdf'
alias gdp-report='gdp-individual-report'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"

# ====================== END UNIVERSITY ======================

export PATH=/Users/georgegillams/bin:/Users/georgegillams/Library/Python/3.6/bin:$HOME/.rvm/bin:/Users/georgegillams/.rvm/gems/ruby-2.3.1/bin:/Users/georgegillams/.rvm/gems/ruby-2.3.1@global/bin:/Users/georgegillams/.rvm/rubies/ruby-2.3.1/bin:/Users/georgegillams/.nvm/versions/node/v8.9.0/bin:/usr/local/sbin:/Users/georgegillams/.cargo/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin:/Library/Frameworks/Mono.framework/Versions/Current/Commands:/Applications/Wireshark.app/Contents/MacOS:/Users/georgegillams/.rvm/bin:/Users/georgegillams/.vimpkg/bin

# added by travis gem
[ -f /Users/georgegillams/.travis/travis.sh ] && source /Users/georgegillams/.travis/travis.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
