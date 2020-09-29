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

info "ZSH loAded"

export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
export ZSH=/Users/georgegillams/.oh-my-zsh
export USER_ZSH=/Users/georgegillams/.zsh

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

source $USER_ZSH/system
source $USER_ZSH/npm
source $USER_ZSH/lang
source $USER_ZSH/git
source $USER_ZSH/docker
source $USER_ZSH/personal
source $USER_ZSH/skyscanner

function gif-make-loop-forever() { convert -delay 5 -loop 0 $@ $@ }

alias optimise-all-pngs='find . -name "*.png" -exec imageoptim {} \;'

alias c='code ./'

alias lightroom-delete-preview-files='find . -name "*Previews.lrdata" -exec rm -rf {} \;'

info "Aliases ready"

export PATH=$HOME/.fastlane/bin:/usr/local/go/bin:/Users/georgegillams/bin:/Users/georgegillams/Library/Python/3.6/bin:/Users/georgegillams/.rvm/gems/ruby-2.3.1@global/bin:/usr/local/sbin:/Users/georgegillams/.cargo/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin:/Library/Frameworks/Mono.framework/Versions/Current/Commands:/Applications/Wireshark.app/Contents/MacOS:/Users/georgegillams/.rvm/bin:/Users/georgegillams/.vimpkg/bin

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# iTerm custom commands:
function iterm2_print_user_vars() {
  iterm2_set_user_var ipAddress $(ipconfig getifaddr en0)
  iterm2_set_user_var nodeVersion $(node -v | cut -d'v' -f2-)
  # iterm2_set_user_var rubyVersion $(rvm current | cut -d'-' -f2-)
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
}

info "Initialising NVM"
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh --no-use # This loads nvm
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm - disabled as it does the same as the line above
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion - disabled as it is too slow!
info "NVM ready"

info "Initialising rbenv"
eval "$(rbenv init -)"

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
  rbenv local
#   if [[ -f .ruby-version && -r .ruby-version ]]; then
#     rvm use
#   elif [[ $(nvm version) != $(nvm version default)  ]]; then
#     info "Reverting to rvm default version"
#     rvm use default
#   fi
}
add-zsh-hook chpwd npm-set-normal-registry-function
add-zsh-hook chpwd load-nvmrc
add-zsh-hook chpwd load-ruby-version
