
# Load zsh autocompletion
if command -v kubectl &>/dev/null; then
  source <(kubectl completion zsh)
fi

alias k='kubectl'

alias k-get-namespaces='k get namespaces'
function k-set-namespace { k config set-context --current --namespace=$1 }

alias k-get-pods='k get pods'