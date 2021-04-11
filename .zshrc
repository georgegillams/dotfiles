startTimeGlobal="$(gdate +%s%N | cut -b1-13)"
startTime="$(gdate +%s%N | cut -b1-13)"

RED='\033[0;31m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
BLUE='\033[0;34m'
NC='\033[0m'

function yellow() {
  echo "${YELLOW}$@${NC}"
}

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

export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
export ZSH=/Users/georgegillams/.oh-my-zsh
export USER_ZSH=/Users/georgegillams/.zsh

export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export ANDROID_HOME="$ANDROID_SDK_ROOT"
export TERM="xterm-256color"
export GPG_TTY=$(tty)

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

export PATH=$HOME/.fastlane/bin:/usr/local/go/bin:/Users/georgegillams/bin:/Users/georgegillams/Library/Python/3.6/bin:/Users/georgegillams/.rvm/gems/ruby-2.3.1@global/bin:/usr/local/sbin:/Users/georgegillams/.cargo/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin:/Library/Frameworks/Mono.framework/Versions/Current/Commands:/Applications/Wireshark.app/Contents/MacOS:/Users/georgegillams/.rvm/bin:/Users/georgegillams/.vimpkg/bin

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

endTime="$(gdate +%s%N | cut -b1-13)"
info "ZSH loaded ($((endTime-startTime))ms)"
startTime="$(gdate +%s%N | cut -b1-13)"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status battery root_indicator background_jobs history time)

ZSH_THEME="powerlevel10k/powerlevel10k"

HIST_STAMPS="dd/mm/yyyy"

plugins=(git osx)

endTime="$(gdate +%s%N | cut -b1-13)"
info "Plugins loaded ($((endTime-startTime))ms)"
startTime="$(gdate +%s%N | cut -b1-13)"

source $ZSH/oh-my-zsh.sh
source $ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

source $USER_ZSH/docker
source $USER_ZSH/git
source $USER_ZSH/lang
source $USER_ZSH/npm
source $USER_ZSH/personal
source $USER_ZSH/skyscanner
source $USER_ZSH/system

source /Users/georgegillams/.config/broot/launcher/bash/br

function gif-make-loop-forever() { convert -delay 5 -loop 0 $@ $@ }

alias optimise-all-pngs='find . -name "*.png" -exec imageoptim {} \;'

alias c='code ./'

alias lightroom-delete-preview-files='find . -name "*Previews.lrdata" -exec rm -rf {} \;'

endTime="$(gdate +%s%N | cut -b1-13)"
info "Aliases ready ($((endTime-startTime))ms)"
startTime="$(gdate +%s%N | cut -b1-13)"

eval "$(rbenv init -)"

endTime="$(gdate +%s%N | cut -b1-13)"
info "rbenv ready ($((endTime-startTime))ms)"
startTime="$(gdate +%s%N | cut -b1-13)"

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh --no-use # This loads nvm
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm - disabled as it does the same as the line above
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion - disabled as it is too slow!

endTime="$(gdate +%s%N | cut -b1-13)"
info "nvm ready ($((endTime-startTime))ms)"
startTime="$(gdate +%s%N | cut -b1-13)"

# iTerm custom commands:
function iterm2_print_user_vars() {
  iterm2_set_user_var ipAddress $(ipconfig getifaddr en0)
  iterm2_set_user_var nodeVersion $(node -v | cut -d'v' -f2-)
  # iterm2_set_user_var rubyVersion $(rvm current | cut -d'-' -f2-)
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
}

endTime="$(gdate +%s%N | cut -b1-13)"
info "iTerm user variables set ($((endTime-startTime))ms)"
startTime="$(gdate +%s%N | cut -b1-13)"

#Auto switch nvm versions:
# place this after nvm initialization!
load-nvmrc() {
  startTime="$(gdate +%s%N | cut -b1-13)"
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    info "Reverting to nvm default version"
    nvm use default
  fi
  endTime="$(gdate +%s%N | cut -b1-13)"
  info "Node version set ($((endTime-startTime))ms)"
}
load-ruby-version() {
  startTime="$(gdate +%s%N | cut -b1-13)"
  rbenv local
  endTime="$(gdate +%s%N | cut -b1-13)"
  info "Ruby version set ($((endTime-startTime))ms)"
#   if [[ -f .ruby-version && -r .ruby-version ]]; then
#     rvm use
#   elif [[ $(nvm version) != $(nvm version default)  ]]; then
#     info "Reverting to rvm default version"
#     rvm use default
#   fi
}

autoload -U add-zsh-hook

add-zsh-hook chpwd npm-set-correct-registry-function
add-zsh-hook chpwd load-nvmrc
add-zsh-hook chpwd load-ruby-version

npm-set-correct-registry-function
load-nvmrc
load-ruby-version

endTimeGlobal="$(gdate +%s%N | cut -b1-13)"
info "Total time taken: $((endTimeGlobal-startTimeGlobal))ms"
