# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

startTimeGlobal="$(gdate +%s%N | cut -b1-13)"
startTime="$(gdate +%s%N | cut -b1-13)"

RED='\033[0;31m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
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

function green() {
  echo "${GREEN}$@${NC}"
}

function info() {
  blue $@
}

function info-secondary() {
  purple $@
}

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

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

endTime="$(gdate +%s%N | cut -b1-13)"
info "ZSH loaded ($((endTime-startTime))ms)"
startTime="$(gdate +%s%N | cut -b1-13)"

ZSH_THEME="powerlevel10k/powerlevel10k"
[[ ! -f ~/.zsh/gh_p10k.zsh ]] || source ~/.zsh/gh_p10k.zsh

HIST_STAMPS="dd/mm/yyyy"

plugins=(
  git macos
  zsh-autosuggestions
  fzf-tab
)

export ASDF_MANUAL_INSTALL_DIR="$HOME/asdf"

# Install via brew broke, so using manual install
if [ -d "$ASDF_MANUAL_INSTALL_DIR/bin" ]; then
  export PATH="$PATH:$ASDF_MANUAL_INSTALL_DIR/bin"
fi

# Load ASDF
# Installation via brew broke, so using manual configuration instead
# if [ -d "$(brew --prefix asdf)" ]; then
#   . $(brew --prefix asdf)/libexec/asdf.sh
# fi
if [ -d "$ASDF_MANUAL_INSTALL_DIR" ]; then
  # This file came from asdf git repo:
  . $ASDF_MANUAL_INSTALL_DIR/asdf.sh
fi

endTime="$(gdate +%s%N | cut -b1-13)"
info "Plugins loaded ($((endTime-startTime))ms)"
startTime="$(gdate +%s%N | cut -b1-13)"

source $ZSH/oh-my-zsh.sh

source $USER_ZSH/gh_docker.zsh
source $USER_ZSH/gh_git.zsh
source $USER_ZSH/gh_lang.zsh
source $USER_ZSH/gh_npm.zsh
source $USER_ZSH/gh_system.zsh
source $USER_ZSH/gh_personal.zsh
source $USER_ZSH/gh_network.zsh

if [[ -f $USER_ZSH/typeform.zsh ]]; then
  source $USER_ZSH/typeform.zsh
fi

alias clear-scrollback-buffer='printf "\e]1337;ClearScrollback\a"'

function gif-make-loop-forever() { convert -delay 5 -loop 0 $@ $@ }

alias optimise-all-pngs='find . -name "*.png" -exec imageoptim {} \;'
alias daily-sign-in='open /Applications/1Password.app && tf-daily-sign-in'

# alias open-code-editor='open -a "WebStorm"'
if [ -x "$(which cursor)" ]; then
  alias open-code-editor='cursor'
else
  alias open-code-editor='code'
fi
alias c='open-code-editor ./'

alias lightroom-delete-preview-files='find . -name "*Previews.lrdata" -exec rm -rf {} \;'
alias premiere-install-LUTs='cd ~/Library/Application\ Support/Adobe/Common/LUTs && mkdir -p Creative Technical && open ./'
alias delete-lrf-files='find . -name "*.LRF" -exec rm -rf {} \; && find . -name "*.SRT" -exec rm -rf {} \;'

function load-nvmrc() {
  if [[ ! -f .tool-versions && -f .nvmrc && -r .nvmrc ]]; then
    echo "nodejs $(cat .nvmrc)" > .tool-versions
    rm .nvmrc
    info-secondary "nvmrc version moved to asdf"
    re-cd
  fi
}

# NOTE: Actual version switching is handled automagically by asdf.
# This function is just used for automatic installation and info logging.
function load-asdf() {
  if [[ -f .tool-versions && -r .tool-versions ]]; then
    startTime="$(gdate +%s%N | cut -b1-13)"
 
    # If versions are not installed, install them
    if asdf current 2>&1 | grep -q "false - Run"; then
      asdf install
    fi

    endTime="$(gdate +%s%N | cut -b1-13)"
    if [ -x "$(which node)" ]; then
      info-secondary "asdf Node version $(node -v) set ($((endTime-startTime))ms)"
      if [ -x "$(which iterm2_set_user_var)" ]; then
        iterm2_set_user_var nodeVersion $(node -v | cut -d'v' -f2-)
      fi
    else
      info-secondary "asdf versions set ($((endTime-startTime))ms)"
    fi
  fi
}

# function load-rvmrc() {
#   startTime="$(gdate +%s%N | cut -b1-13)"
#   if [[ -f .ruby-version && -r .ruby-version ]]; then
#     rbenv local
#     rvm use
#   fi
#   endTime="$(gdate +%s%N | cut -b1-13)"
#   info-secondary "Ruby version $(ruby -v) set ($((endTime-startTime))ms)"
#   if [ -x "$(which iterm2_set_user_var)" ]; then
#     iterm2_set_user_var rubyVersion $(rvm current | cut -d'-' -f2-)
#   fi
# }

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
}

endTime="$(gdate +%s%N | cut -b1-13)"
info "iTerm user variables set ($((endTime-startTime))ms)"
# startTime="$(gdate +%s%N | cut -b1-13)"

# eval "$(rbenv init -)"

# endTime="$(gdate +%s%N | cut -b1-13)"
# info "rvm initialised ($((endTime-startTime))ms)"
startTime="$(gdate +%s%N | cut -b1-13)"

endTime="$(gdate +%s%N | cut -b1-13)"
info "nvm initialised ($((endTime-startTime))ms)"
startTime="$(gdate +%s%N | cut -b1-13)"

# bun completions
[ -s "/Users/george.gillams/.bun/_bun" ] && source "/Users/george.gillams/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
if [ -d "$BUN_INSTALL/bin" ]; then
  export PATH="$BUN_INSTALL/bin:$PATH"
fi

# c++
export CPLUS_INCLUDE_PATH=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/c++/v1

endTime="$(gdate +%s%N | cut -b1-13)"
info "bun initialised ($((endTime-startTime))ms)"
startTime="$(gdate +%s%N | cut -b1-13)"

function on-change-dir() {
  load-nvmrc
  load-asdf
  # load-rvmrc
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
if [ -d "$HOME/.rvm/bin" ]; then
  export PATH="$PATH:$HOME/.rvm/bin"
fi

on-change-dir

endTimeGlobal="$(gdate +%s%N | cut -b1-13)"
info "Total time taken: $((endTimeGlobal-startTimeGlobal))ms"

# PostgreSQL
if [ -d "/opt/homebrew/opt/libpq/bin" ]; then
  export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
fi

PATH=~/.console-ninja/.bin:$PATH