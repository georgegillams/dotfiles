startTimeGlobal="$(gdate +%s%N | cut -b1-13)"
startTime="$(gdate +%s%N | cut -b1-13)"

RED='\033[0;31m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
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

function purple() {
  echo "${PURPLE}$@${NC}"
}

function info() {
  blue $@
}

function info-secondary() {
  purple $@
}

export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
export ZSH=$HOME/.oh-my-zsh
export USER_ZSH=$HOME/.zsh

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

export PATH=~/usr/bin:/bin:/usr/sbin:/sbin:$PATH

# Set a default Node path so that we can access node without calling `nvm use default`
export PATH=~/.nvm/versions/node/v20.7.0/bin:$PATH

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

endTime="$(gdate +%s%N | cut -b1-13)"
info "ZSH loaded ($((endTime-startTime))ms)"
startTime="$(gdate +%s%N | cut -b1-13)"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)

ZSH_THEME="powerlevel10k/powerlevel10k"

HIST_STAMPS="dd/mm/yyyy"

plugins=(
  git macos
  zsh-autosuggestions
)

endTime="$(gdate +%s%N | cut -b1-13)"
info "Plugins loaded ($((endTime-startTime))ms)"
startTime="$(gdate +%s%N | cut -b1-13)"

source $ZSH/oh-my-zsh.sh
source $ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

source $USER_ZSH/gh_docker
source $USER_ZSH/gh_git
source $USER_ZSH/gh_lang
source $USER_ZSH/gh_npm
source $USER_ZSH/gh_system
source $USER_ZSH/gh_personal

source $USER_ZSH/typeform

alias clear-scrollback-buffer='printf "\e]1337;ClearScrollback\a"'

function gif-make-loop-forever() { convert -delay 5 -loop 0 $@ $@ }

alias optimise-all-pngs='find . -name "*.png" -exec imageoptim {} \;'
alias daily-sign-in='open /Applications/1Password.app && tf-daily-sign-in'

alias open-code-editor='code'
alias c='open-code-editor ./'

alias lightroom-delete-preview-files='find . -name "*Previews.lrdata" -exec rm -rf {} \;'

function load-nvmrc() {
  startTime="$(gdate +%s%N | cut -b1-13)"
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  fi
  endTime="$(gdate +%s%N | cut -b1-13)"
  if [ -x "$(which node)" ]; then
    info-secondary "Node version $(node -v) set ($((endTime-startTime))ms)"
    if [ -x "$(which iterm2_set_user_var)" ]; then
      iterm2_set_user_var nodeVersion $(node -v | cut -d'v' -f2-)
    fi
  fi
}

function load-rvmrc() {
  startTime="$(gdate +%s%N | cut -b1-13)"
  if [[ -f .ruby-version && -r .ruby-version ]]; then
    rbenv local
    rvm use
  fi
  endTime="$(gdate +%s%N | cut -b1-13)"
  info-secondary "Ruby version $(ruby -v) set ($((endTime-startTime))ms)"
  if [ -x "$(which iterm2_set_user_var)" ]; then
    iterm2_set_user_var rubyVersion $(rvm current | cut -d'-' -f2-)
  fi
}

endTime="$(gdate +%s%N | cut -b1-13)"
info "Aliases ready ($((endTime-startTime))ms)"
startTime="$(gdate +%s%N | cut -b1-13)"

# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

endTime="$(gdate +%s%N | cut -b1-13)"
info "Fig pre ready ($((endTime-startTime))ms)"
startTime="$(gdate +%s%N | cut -b1-13)"

# iTerm custom commands:
function iterm2_print_user_vars() {
  iterm2_set_user_var ipAddress $(ipconfig getifaddr en0)
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
}

endTime="$(gdate +%s%N | cut -b1-13)"
info "iTerm user variables set ($((endTime-startTime))ms)"
startTime="$(gdate +%s%N | cut -b1-13)"

eval "$(rbenv init -)"

endTime="$(gdate +%s%N | cut -b1-13)"
info "rvm initialised ($((endTime-startTime))ms)"
startTime="$(gdate +%s%N | cut -b1-13)"

export NVM_LAZY=1
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

endTime="$(gdate +%s%N | cut -b1-13)"
info "nvm initialised ($((endTime-startTime))ms)"
startTime="$(gdate +%s%N | cut -b1-13)"

# bun completions
[ -s "/Users/george.gillams/.bun/_bun" ] && source "/Users/george.gillams/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

endTime="$(gdate +%s%N | cut -b1-13)"
info "bun initialised ($((endTime-startTime))ms)"
startTime="$(gdate +%s%N | cut -b1-13)"

function on-change-dir() {
  load-nvmrc
  load-rvmrc
}

#Auto switch nvm versions:
autoload -U add-zsh-hook
add-zsh-hook chpwd on-change-dir

endTime="$(gdate +%s%N | cut -b1-13)"
info "chpwd hooks initialised ($((endTime-startTime))ms)"

startTime="$(gdate +%s%N | cut -b1-13)"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

endTime="$(gdate +%s%N | cut -b1-13)"
info "fig post ready ($((endTime-startTime))ms)"
startTime="$(gdate +%s%N | cut -b1-13)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

on-change-dir

endTimeGlobal="$(gdate +%s%N | cut -b1-13)"
info "Total time taken: $((endTimeGlobal-startTimeGlobal))ms"