. ./00-setup-type.sh

# VSCode / Cursor extensions

if command -v cursor &>/dev/null; then
  editor="cursor"
elif command -v code &>/dev/null; then
  editor="code"
else
  echo "Neither the 'code' nor 'cursor' CLI was found in PATH."
  echo "Open VS Code or Cursor, run 'Install \"code\" command in PATH' or 'Install \"cursor\" command in PATH' from the Command Palette, then re-run this script."
  exit 1
fi

echo "Using $editor CLI"

$editor --install-extension DavidAnson.vscode-markdownlint
$editor --install-extension dbaeumer.vscode-eslint
$editor --install-extension esbenp.prettier-vscode
$editor --install-extension ms-vscode.vscode-typescript-next
$editor --install-extension redhat.vscode-xml
$editor --install-extension redhat.vscode-yaml
$editor --install-extension rust-lang.rust-analyzer
$editor --install-extension streetsidesoftware.code-spell-checker
$editor --install-extension vscodevim.vim


if [[ $setup_type == "WORK_SETUP_PROFILE_HS" ]]; then
  $editor --install-extension GitLab.gitlab-workflow
  $editor --install-extension hashicorp.terraform
  $editor --install-extension jnoortheen.nix-ide
  $editor --install-extension oxc.oxc-vscode
fi

if [[ $setup_type == "PERSONAL_SETUP_PROFILE_1" ]]; then
  $editor --install-extension github.vscode-github-actions
  $editor --install-extension github.vscode-pull-request-github
  $editor --install-extension matthizou.translation-keys-lookup
  $editor --install-extension mattpocock.ts-error-translator
  $editor --install-extension styled-components.vscode-styled-components
  $editor --install-extension stylelint.vscode-stylelint
  $editor --install-extension wix.vscode-import-cost
fi


if [[ $editor == "cursor" ]]; then
  defaults write com.todesktop.230313mzl4w4u92 ApplePressAndHoldEnabled -bool false
else
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
fi

if $setup_type == "PERSONAL_SETUP_PROFILE_1"; then
  echo "Copy keybindings and settings"
  open "$MY_PERSONAL_DRIVE/2_Areas/Apps/VSCode and Cursor"
fi

if $setup_type == "WORK_SETUP_PROFILE_HS"; then
  echo "Copy keybindings and settings"
  open "$HS_DRIVE/02_Areas/Apps/VSCode"
fi

# Other useful extensions:
#     $editor --install-extension christian-kohler.npm-intellisense
#     $editor --install-extension danishsarwar.reverse-search
#     $editor --install-extension eamodio.gitlens
#     $editor --install-extension firsttris.vscode-jest-runner
#     $editor --install-extension formulahendry.auto-close-tag
#     $editor --install-extension formulahendry.auto-rename-tag
#     $editor --install-extension github.copilot
#     $editor --install-extension github.copilot-chat
#     $editor --install-extension iulian-radu-at.find-unused-exports
#     $editor --install-extension jannisx11.batch-rename-extension
#     $editor --install-extension juanallo.vscode-dependency-cruiser
#     $editor --install-extension manuelartero.lock-tree
#     $editor --install-extension mateocerquetella.xcode-12-theme
#     $editor --install-extension mquandalle.graphql
#     $editor --install-extension ms-azuretools.vscode-docker
#     $editor --install-extension ms-vscode.makefile-tools
#     $editor --install-extension ms-vsliveshare.vsliveshare
#     $editor --install-extension mskelton.npm-outdated
#     $editor --install-extension mxsdev.typescript-explorer
#     $editor --install-extension naumovs.color-highlight
#     $editor --install-extension raymondcamden.htmlescape-vscode-extension
#     $editor --install-extension rwu823.open-folder
#     $editor --install-extension shd101wyy.markdown-preview-enhanced
#     $editor --install-extension sz-p.dependencygraph
#     $editor --install-extension unifiedjs.vscode-mdx
#     $editor --install-extension usernamehw.search
#     $editor --install-extension vitest.explorer
#     $editor --install-extension weijunyu.vscode-json-path
#     $editor --install-extension zainchen.json
