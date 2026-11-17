# ========================= CLANG =========================

alias clang-all-the-things='clang-format -i **/*.h **/*.m **/*.mc'

# ========================= XCODE =========================

alias xcode='open'
alias xcode-delete-derived-data='rm -rf ~/Library/Developer/Xcode/DerivedData/ && mkdir ~/Library/Developer/Xcode/DerivedData'
alias xcode-fix-AST-error='rm -rf ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex'
alias simulator-reset-all-devices='(pkill Simulator || true) && xcrun simctl erase all'
alias be='bundle exec'

# ========================= RUST =========================

if [[ -f "$HOME/.cargo/env" ]]; then
  . "$HOME/.cargo/env"
fi

# ========================= ANDROID =========================

alias AndroidStudio="open -a /Applications/Android\ Studio.app"

# ========================= REDIS =========================

alias redis-reset='redis-cli flushall && redis-cli flushall && redis-cli flushall && redis-cli flushall && redis-cli flushall'

# ========================== ENV ==========================

# Usage: _env-file-set <file> <key> <value>
function _env-file-set() {
  { grep -v "^${2}=" "$1" 2>/dev/null; print -r -- "${2}=${3}"; } > "${1}.tmp" && mv "${1}.tmp" "$1"
}

# Ensure an env file exists and contains the given keys.
#
# Usage: check-and-set-env [-b <base>] [-t <target>] (KEY | KEY=VALUE)...
#   -b <base>    File to copy to <target> if <target> doesn't exist.
#   -t <target>  Env file to check and update (default: .env).
#   KEY=VALUE    Written to <target> unconditionally, without prompting.
#   KEY          Prompted for if unset in <target> (or if <target> was just
#                copied from <base>, whose values are assumed placeholders).
#
# Examples:
#   check-and-set-env API_KEY DB_URL
#   check-and-set-env -b .env.example -t .env.local API_KEY DB_URL=postgres://localhost/db
function check-and-set-env() {
  local -A opts
  zparseopts -D -F -A opts -- b: t: || return 1

  local base_file="${opts[-b]}"
  local env_file="${opts[-t]:-.env}"
  local -a keys=() missing=()
  local arg key val copied=

  if [[ ! -f "$env_file" && -n "$base_file" ]]; then
    [[ -f "$base_file" ]] || { echo "❌ Base file ${base_file} not found."; return 1; }
    cp "$base_file" "$env_file" || return 1
    echo "📄 Copied ${base_file} to ${env_file}"
    copied=1
  fi

  for arg in "$@"; do
    if [[ "$arg" == *=* ]]; then
      _env-file-set "$env_file" "${arg%%=*}" "${arg#*=}" || return 1
    else
      keys+=("$arg")
    fi
  done

  # Unattended shells (e.g. software-factory) can't answer the prompts
  [[ -n "$DOTFILES_SKIP_PROMPTS" ]] && return 0

  if [[ -n "$copied" ]]; then
    missing=("${keys[@]}")
  else
    for key in "${keys[@]}"; do
      grep -qE "^${key}=.+" "$env_file" 2>/dev/null || missing+=("$key")
    done
  fi

  for key in "${missing[@]}"; do
    echo "⚠️  ${key} not set in ${env_file}"
    read -s "val?Enter value for ${key}: "
    echo
    [[ -n "$val" ]] || { echo "Skipped (empty)."; continue; }
    _env-file-set "$env_file" "$key" "$val" || return 1
  done
}