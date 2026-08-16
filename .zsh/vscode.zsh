# ========================== VSCODE / CURSOR ==========================

function vscode-backup() {
  local dests=()

  if [[ -d "$HS_DRIVE/02_Areas/Apps/VSCode" ]]; then
    dests+=("$HS_DRIVE/02_Areas/Apps/VSCode")
  fi
  if [[ -d "$MY_PERSONAL_DRIVE/2_Areas/Apps/VSCode and Cursor" ]]; then
    dests+=("$MY_PERSONAL_DRIVE/2_Areas/Apps/VSCode and Cursor")
  fi

  if [[ ${#dests[@]} -eq 0 ]]; then
    warn "No VSCode/Cursor backup directory found"
    return 1
  fi

  local -a editor_labels=()
  local -a editor_srcs=()

  if [[ -d "/Applications/Cursor.app" ]] || command -v cursor &>/dev/null; then
    editor_labels+=("Cursor")
    editor_srcs+=("$HOME/Library/Application Support/Cursor/User")
  fi
  if [[ -d "/Applications/Visual Studio Code.app" ]] || command -v code &>/dev/null; then
    editor_labels+=("VSCode")
    editor_srcs+=("$HOME/Library/Application Support/Code/User")
  fi

  if [[ ${#editor_labels[@]} -eq 0 ]]; then
    warn "Neither Cursor nor VSCode is installed"
    return 1
  fi

  local stamp dest i label src dest_dir copied
  stamp="$(date +%Y%m%dT%H%M)"

  for dest in "${dests[@]}"; do
    for i in {1..${#editor_labels[@]}}; do
      label="${editor_labels[$i]}"
      src="${editor_srcs[$i]}"
      dest_dir="$dest/$stamp"
      if [[ ${#editor_labels[@]} -gt 1 ]]; then
        dest_dir="$dest/$stamp/${(L)label}"
      fi

      copied=0
      if [[ -f "$src/settings.json" || -f "$src/keybindings.json" ]]; then
        mkdir -p "$dest_dir"
      fi
      if [[ -f "$src/settings.json" ]]; then
        cp -p "$src/settings.json" "$dest_dir/settings.json"
        copied=1
      fi
      if [[ -f "$src/keybindings.json" ]]; then
        cp -p "$src/keybindings.json" "$dest_dir/keybindings.json"
        copied=1
      fi

      if [[ $copied -eq 1 ]]; then
        success "Backed up $label settings to $dest_dir"
      else
        warn "No $label settings.json or keybindings.json found in $src"
      fi
    done
  done
}
