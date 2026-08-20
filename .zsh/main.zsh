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
  blue "[INFO] $@"
}

function info-secondary() {
  purple "[INFO] $@"
}

function success() {
  green "[SUCCESS] $@"
}

function warn() {
  yellow "[WARN] $@"
}

function error() {
  red "[ERROR] $@"
}

. "/Users/george.gillams/Documents/github.com/georgegillams/dotfiles/system-install/00-setup-type.sh" >/dev/null
info "Machine configuration: $setup_type"

export ZSH=$HOME/.oh-my-zsh
export USER_ZSH="/Users/george.gillams/Documents/github.com/georgegillams/dotfiles/.zsh"

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

export PATH=~/usr/bin:/bin:/usr/sbin:/sbin:~/go/bin/:$PATH

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

endTime="$(gdate +%s%N | cut -b1-13)"
info "ZSH loaded ($((endTime-startTime))ms)"
startTime="$(gdate +%s%N | cut -b1-13)"

HIST_STAMPS="dd/mm/yyyy"

plugins=(
  git macos
  # zsh-autosuggestions
  # fzf-tab
)

# asdf — only configure when installed via brew
_asdf_sh="$(brew --prefix asdf 2>/dev/null)/libexec/asdf.sh"
if [[ -f "$_asdf_sh" ]]; then
  . "$_asdf_sh"
fi
unset _asdf_sh

# nvm — only configure when installed
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
_nvm_sh=""
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  _nvm_sh="$NVM_DIR/nvm.sh"
elif [[ -s "$(brew --prefix nvm 2>/dev/null)/nvm.sh" ]]; then
  _nvm_sh="$(brew --prefix nvm)/nvm.sh"
fi
if [[ -n "$_nvm_sh" ]]; then
  . "$_nvm_sh"
fi
unset _nvm_sh

# rvm — only configure when installed
if [[ -d "$HOME/.rvm/bin" ]]; then
  export PATH="$PATH:$HOME/.rvm/bin"
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
fi

# rbenv — only configure when installed
if command -v rbenv &>/dev/null; then
  eval "$(rbenv init - zsh)"
fi

endTime="$(gdate +%s%N | cut -b1-13)"
info "Plugins loaded ($((endTime-startTime))ms)"
startTime="$(gdate +%s%N | cut -b1-13)"

# Because sourcing this can be noisy, route output to /dev/null
source $ZSH/oh-my-zsh.sh >> /dev/null

source $USER_ZSH/docker.zsh
source $USER_ZSH/git.zsh
source $USER_ZSH/lang.zsh
source $USER_ZSH/npm.zsh
source $USER_ZSH/system.zsh
source $USER_ZSH/personal.zsh
source $USER_ZSH/vscode.zsh
source $USER_ZSH/network.zsh

if [[ -f $USER_ZSH/typeform.zsh ]]; then
  source $USER_ZSH/typeform.zsh
fi
if [[ -f "$HS_DRIVE/02_Areas/Apps/.zsh/hs.zsh" ]]; then
  source "$HS_DRIVE/02_Areas/Apps/.zsh/hs.zsh"
fi

alias clear-scrollback-buffer='printf "\e]1337;ClearScrollback\a"'

function gif-make-loop-forever() { convert -delay 5 -loop 0 $@ $@ }

alias optimise-all-pngs='find . -name "*.png" -exec imageoptim {} \;'
alias daily-sign-in='open /Applications/1Password.app && tf-daily-sign-in'

 if [ -x "$(which cursor)" ]; then
   alias open-code-editor='cursor'
 else
   alias open-code-editor='code'
 fi
alias c='open-code-editor ./'

alias lightroom-delete-preview-files='find . -name "*Previews.lrdata" -exec rm -rf {} \;'
alias premiere-install-LUTs='cd ~/Library/Application\ Support/Adobe/Common/LUTs && mkdir -p Creative Technical && open ./'
alias delete-lrf-files='find . -name "*.LRF" -exec rm -rf {} \; && find . -name "*.SRT" -exec rm -rf {} \;'

function has-nix-project() {
  [[ -f flake.nix || -f shell.nix || -f default.nix ]]
}

function has-asdf() {
  command -v asdf &>/dev/null
}

function has-nvm() {
  command -v nvm &>/dev/null
}

function has-rvm() {
  command -v rvm &>/dev/null
}

function has-rbenv() {
  command -v rbenv &>/dev/null
}

# NOTE: Actual version switching is handled automagically by asdf.
# This function is just used for automatic installation and info logging.
function load-asdf() {
  if ! has-asdf || [[ ! -f .tool-versions || ! -r .tool-versions ]]; then
    return
  fi

  startTime="$(gdate +%s%N | cut -b1-13)"

  # If versions are not installed, install them
  if asdf current 2>&1 | grep -q "false - Run"; then
    asdf install
  fi

  endTime="$(gdate +%s%N | cut -b1-13)"
  if command -v node &>/dev/null; then
    info-secondary "asdf Node version $(node -v) set ($((endTime-startTime))ms)"
    if command -v iterm2_set_user_var &>/dev/null; then
      iterm2_set_user_var nodeVersion $(node -v | cut -d'v' -f2-)
    fi
  else
    info-secondary "asdf versions set ($((endTime-startTime))ms)"
  fi
}

function load-nvm() {
  if ! has-nvm || [[ ! -f .nvmrc || ! -r .nvmrc ]]; then
    return
  fi

  startTime="$(gdate +%s%N | cut -b1-13)"
  local nvmrc_version
  nvmrc_version="$(tr -d '[:space:]' < .nvmrc)"

  if ! nvm use "$nvmrc_version" 2>/dev/null; then
    nvm install "$nvmrc_version"
    nvm use "$nvmrc_version"
  fi

  endTime="$(gdate +%s%N | cut -b1-13)"
  if command -v node &>/dev/null; then
    info-secondary "nvm Node version $(node -v) set ($((endTime-startTime))ms)"
    if command -v iterm2_set_user_var &>/dev/null; then
      iterm2_set_user_var nodeVersion $(node -v | cut -d'v' -f2-)
    fi
  fi
}

function load-rvm() {
  if ! has-rvm || [[ ! -f .ruby-version || ! -r .ruby-version ]]; then
    return
  fi

  startTime="$(gdate +%s%N | cut -b1-13)"
  rvm use
  endTime="$(gdate +%s%N | cut -b1-13)"
  if command -v ruby &>/dev/null; then
    info-secondary "Ruby version $(ruby -v) set ($((endTime-startTime))ms)"
    if command -v iterm2_set_user_var &>/dev/null; then
      iterm2_set_user_var rubyVersion $(rvm current 2>/dev/null | cut -d'-' -f2-)
    fi
  fi
}

function load-rbenv() {
  if ! has-rbenv || [[ ! -f .ruby-version || ! -r .ruby-version ]]; then
    return
  fi

  startTime="$(gdate +%s%N | cut -b1-13)"
  rbenv local
  endTime="$(gdate +%s%N | cut -b1-13)"
  if command -v ruby &>/dev/null; then
    info-secondary "rbenv Ruby version $(ruby -v) set ($((endTime-startTime))ms)"
    if command -v iterm2_set_user_var &>/dev/null; then
      iterm2_set_user_var rubyVersion $(rbenv version-name 2>/dev/null)
    fi
  fi
}

function apply-tool-versions() {
  if has-nix-project; then
    return
  fi

  if has-asdf && [[ -f .tool-versions && -r .tool-versions ]]; then
    load-asdf
    return
  fi

  if [[ -f .nvmrc && -r .nvmrc ]] && has-nvm; then
    load-nvm
    return
  fi

  if [[ -f .ruby-version && -r .ruby-version ]] && has-rvm; then
    load-rvm
    return
  fi

  if [[ -f .ruby-version && -r .ruby-version ]] && has-rbenv; then
    load-rbenv
    return
  fi
}

endTime="$(gdate +%s%N | cut -b1-13)"
info "Aliases ready ($((endTime-startTime))ms)"

startTime="$(gdate +%s%N | cut -b1-13)"

# iTerm custom commands:
function iterm2_print_user_vars() {
  iterm2_set_user_var ipAddress $(ipconfig getifaddr en0)
}

endTime="$(gdate +%s%N | cut -b1-13)"
info "iTerm user variables set ($((endTime-startTime))ms)"

startTime="$(gdate +%s%N | cut -b1-13)"

function on-change-dir() {
  apply-tool-versions
}

#Auto switch nvm versions:
autoload -U add-zsh-hook
add-zsh-hook chpwd on-change-dir

endTime="$(gdate +%s%N | cut -b1-13)"
info "chpwd hooks initialised ($((endTime-startTime))ms)"

startTime="$(gdate +%s%N | cut -b1-13)"
if [ -x "$(which starship)" ]; then
  eval "$(starship init zsh)"
fi
endTime="$(gdate +%s%N | cut -b1-13)"
info "starship initialised ($((endTime-startTime))ms)"

on-change-dir

endTimeGlobal="$(gdate +%s%N | cut -b1-13)"
info "Total time taken: $((endTimeGlobal-startTimeGlobal))ms"

# PostgreSQL
if [ -d "/opt/homebrew/opt/libpq/bin" ]; then
  export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
fi


export PATH="/Users/george.gillams/.local/bin:$PATH"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/george.gillams/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
