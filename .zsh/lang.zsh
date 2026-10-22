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

#   -t <target>  Env file to check and update (default: .env).
#
# Examples:
#   check-and-set-env API_KEY DB_URL
#   check-and-set-env -b .env.example -t .env.local API_KEY DB_URL
function check-and-set-env() {
  local -A opts
  zparseopts -D -F -A opts -- b: t: || return 1

  local base_file="${opts[-b]}"
  local env_file="${opts[-t]:-.env}"
  local -a missing=()
  local key val

  if [[ ! -f "$env_file" && -n "$base_file" ]]; then
    [[ -f "$base_file" ]] || { echo "❌ Base file ${base_file} not found."; return 1; }
    cp "$base_file" "$env_file" || return 1
    echo "📄 Copied ${base_file} to ${env_file}"
    missing=("$@")
  else
    for key in "$@"; do
      grep -qE "^${key}=.+" "$env_file" 2>/dev/null || missing+=("$key")
    done
  fi

  for key in "${missing[@]}"; do
    echo "⚠️  ${key} not set in ${env_file}"
    read -s "val?Enter value for ${key}: "
    echo
    [[ -n "$val" ]] || { echo "Skipped (empty)."; continue; }
    { grep -v "^${key}=" "$env_file" 2>/dev/null; echo "${key}=${val}"; } > "${env_file}.tmp" && mv "${env_file}.tmp" "$env_file"
  done
}