function _set-git-base-branch() {
  if [[ $(pwd) == *"homebridge-petkit-platform"* ]]; then
    GIT_BASE_BRANCH="master"
  elif [[ $(pwd) == *"homebridge-eufy-robovac"* || $(pwd) == *"homebridge-ecovacs"* ]]; then
    GIT_BASE_BRANCH="latest"
  elif [[ $(pwd) == *"gitlab."* ]]; then
    GIT_BASE_BRANCH="develop"
  else
    GIT_BASE_BRANCH="main"
  fi
}
chpwd_functions+=(_set-git-base-branch)
_set-git-base-branch

# Prints the root of the current git repo; fails if not inside one
function git-repo-root() {
  git rev-parse --show-toplevel 2>/dev/null
}

alias gh-prs='gh pr list'
alias gh-check-if-pr-exists='gh pr view > /dev/null'
alias gh-create-pr='gh pr create'


function IMPLEMENTATION-gh-view-or-create-pr-web() {
  git rev-parse --git-dir &>/dev/null || return 1
  gh pr view --web 2>/dev/null || gh pr create --web
}

function gh-view-or-create-pr-web() {
  git rev-parse --git-dir &>/dev/null || return 1

  if [[ $(git config --get remote.origin.url) == *"gitlab"* ]] then;
    IMPLEMENTATION-gitlab-view-or-create-pr-web
    return
  fi;

  IMPLEMENTATION-gh-view-or-create-pr-web
}

function gh-create-pr-web-if-none() {
  # check if a PR exists
  gh-check-if-pr-exists
  if [[ $? != 0 ]] then;
    # If a PR didn't exist, create it:
    IMPLEMENTATION-gh-create-pr-web
  fi;
}

alias gh-list-all-tf-prs='gh search prs --author="@me" --owner="Typeform"'

alias IMPLEMENTATION-gh-cancel-pr-jobs='node ~/Documents/github.com/georgegillams/dotfiles/gh-cancel-jobs.js'
alias gh-cancel-pr-jobs='IMPLEMENTATION-gh-cancel-pr-jobs && sleep 5 && IMPLEMENTATION-gh-cancel-pr-jobs && sleep 5 && IMPLEMENTATION-gh-cancel-pr-jobs'

alias git-show-me-how-to-view-a-forked-branch='echo "gco -b username-branch-name master\ngit pull https://github.com/username/backpack.git branch-name"'
alias git-show-me-how-to-unfold-all-rich-diffs='echo "const toClick = document.querySelectorAll(\`[aria-label=\"Display the rich diff\"]\`);
for (let i = toClick.length - 1; i >= 0; i -= 1){
toClick[i].click();
}" | pbcopy'
alias git-show-me-how-to-unfold-all-gh-long-diffs='echo "const toClick = document.getElementsByClassName(\"load-diff-button btn-link width-full\");
for (let i = toClick.length - 1; i >= 0; i -= 1){
toClick[i].click();
}" | pbcopy'
alias git-show-me-how-to-unfold-all-gh-comments='echo "const toClick = document.getElementsByClassName(\"btn-link text-gray float-right f6 outdated-comment-label show-outdated-button js-details-target\");
for (let i = toClick.length - 1; i >= 0; i -= 1){
toClick[i].click();
}" | pbcopy'
alias show-me-how-to-click-all-the-buttons='echo "const buttons = document.getElementsByTagType(\"BUTTON\");
for (let i = buttons.length - 1; i >= 0; i -= 1){
  const button = buttons[i];
  if(button.getAttribute(\"aria-label\") === \"Move rule down: FORWARD TO GEORGEGILLAMS.CO.UK\"){
   console.log(button)
    button.click();
    console.log(\"clicked\");
  }
}" | pbcopy'
alias show-me-how-to-repeatedly-click-a-button='echo "setInterval(() => {
[...document.getElementsByTagName(\"button\")].find(b => b.getAttribute(\"aria-label\") === \"Yes button\")?.click()
}, 500)" | pbcopy'
alias git-prepend-branch-name='node ~/Documents/github.com/georgegillams/dotfiles/prepend-ticket.js'
alias git-rebase-keep-their-changes='git checkout --ours . && git add . && git rebase --continue'
alias git-rebase-keep-our-changes='git checkout --theirs . && git add . && git rebase --continue'
alias gml='gco $GIT_BASE_BRANCH && git-fetch && git reset --hard origin/$GIT_BASE_BRANCH && git pull && (git branch -D $(git branch | grep -v "$GIT_BASE_BRANCH") || true) && git submodule update && git reset --hard HEAD && git reset --recurse-submodules'
alias gaa-no-image-optimisation='git add .'
alias gaa='git-pre-push && gaa-no-image-optimisation'
alias git-reset='red "ABOUT TO CLEAR ALL CHANGES\nTHATS ALL CHANGES\nALL OF THEM" && git-pre-push && gaa-no-image-optimisation && git reset --hard HEAD && git reset --recurse-submodules'
alias git-reset-unstaged='yellow "ABOUT TO CLEAR UNSTAGED CHANGES\nUNSTAGED CHANGES WILL BE GONE\nALSO NEW FILES THAT ARENT STAGED" && git-pre-push && git checkout -- .'
alias git-fetch='git fetch --all'
alias gri='HUSKY=0 git rebase -i'
alias git-pull-master-from-upstream='echo "ensure upstream is set using \"git remote add upstream URL\"" && git fetch upstream && git merge upstream/master && git remote remove upstream && git push origin origin/master'
alias git-pull-main-from-upstream='echo "ensure upstream is set using \"git remote add upstream URL\"" && git fetch upstream && git merge upstream/main && git remote remove upstream && git push origin origin/main'
alias git-pre-push='git status && sleep 3'
alias git-rename-last-commit='git commit --amend --no-verify'
alias gamp='git-pre-push && gcn! --no-verify && gpf'
alias gamp-with-verification='git-pre-push && gcn! && gpf-with-verification'
alias git-test-amend-push='fixtest && git add . && gitamendpush'
alias gpf-with-verification='ggf && git push --no-verify --set-upstream $(git remote) $(git branch | grep \* | cut -d " " -f2)'
alias gpf='git push --force --no-verify && gh-view-or-create-pr-web'
alias git-yolo='gpf'
alias git-clear-cache='git rm -r --cached . && git add . && git commit -m && git push ~'
function gcmpWithType() { git-pre-push && git commit -m "$(git-prepend-branch-name $@)" --no-verify && gpf }
function gcmpcd() { gcmpWithType $@ cd }
function gcmpci() { gcmpWithType $@ ci }
function gcmpfix() { gcmpWithType $@ fix }
function gcmpfeat() { gcmpWithType $@ feat }
function gcmpchore() { gcmpWithType $@ chore }
function gcmpdocs() { gcmpWithType $@ docs }
function gcmpbreaking() { git-pre-push && git commit -m "$(git-prepend-branch-name $@ feat !)" -m "BREAKING CHANGE: $@" --no-verify && gpf }
function git-revert-to-main() { rm -rf $@ && git checkout origin/$GIT_BASE_BRANCH $@ }
function whoamip() { ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' }
function git-rename-branch() {
  oldBranchName=$(git branch | grep \* | cut -d " " -f2)
  newBranchName=$1
  git branch -m $newBranchName
  git push origin :$oldBranchName $newBranchName
  git push origin -u $newBranchName
}
function git-delete-tag() {
  git push --delete origin $@ & git tag -d $@
}
function git-create-tag() {
  git tag $@
  git push --tags
}
function git-create-note-for-beta-semantic-release() {
  git notes --ref semantic-release add -f -m '{"channels":["beta"]}' $@
  git push --force origin refs/notes/semantic-release
}
alias gclean='git clean -xdf'
alias git-pull-fork='node ~/Documents/github.com/georgegillams/dotfiles/pull-forked-branch.js'
alias git-submodules-init='git submodule update --init --recursive'
alias git-submodules-pull='git submodule update --recursive --remote'
alias git-disable-gpg='(git config --global commit.gpgsign false && git config --global tag.forceSignAnnotated false && git config --global --unset gpg.program) || true'
alias git-enable-gpg='git config --global commit.gpgsign true && git config --global tag.forceSignAnnotated true && git config --global gpg.program gpg'
alias git-status-count='git status --porcelain | wc -l'
alias git-status-count-except-nvmrc-tool-version='git status --porcelain | grep -v -E "(\.nvmrc|\.tool-versions)" | wc -l'
alias git-stash-unstaged='git stash push --keep-index'
function git-stash-specific-file() { ga "$1" && g stash push "$1" }

alias grm='git-fetch && (git rebase origin/$GIT_BASE_BRANCH | grep CONFLICT || true) && git-submodules-pull'
function gro() {
  if [[ -z "$1" ]]; then
    echo "please provide base branch for the rebase"
    return 1
  fi
  if [[ -n "$(git status --porcelain --untracked-files=no)" ]]; then
    red "You have uncommitted changes. Commit or stash them before rebasing"
    return 1
  fi
  local commit_hash="$2"
  if [[ -z "$commit_hash" ]]; then
    info "You'll need to provide the git commit from which you want to keep this branch's commits"
    read -t 5
    git log
    read "commit_hash?Paste the commit hash from which you want to keep this branch's commits: "
    if [[ -z "$commit_hash" ]]; then
      echo "no commit hash provided"
      return 1
    fi
  fi
  git-fetch && (git rebase --onto "$1" "$commit_hash" | grep CONFLICT || true) && git-submodules-pull
}
function grom() {
  gro "origin/$GIT_BASE_BRANCH" "$1"
}
alias grm-stacked='red "Use grom" instead'

# Allows us to use git diff with file-path autocomplete
function git-diff() { eval "git diff $@" }

alias gh-auto-merge='gh pr merge --auto --squash'
alias gh-admin-merge='red "ABOUT TO ADMIN MERGE" && sleep 5 && gh pr merge --admin --squash'
alias gh-pr-ready='gh pr ready'

alias gh-push-to-beta='git push origin HEAD:beta --force'

function cd-if-necessary() {
  if [[ "$(pwd)" != "$1" ]]; then
    cd $1
  fi
}

function clone-and-cd() {
  method=$1
  host=$2
  org=$3
  repo=$4
  hostPath="$HOME/Documents/$host"
  orgPath="$hostPath/$org"
  repoDir="$repo"
  if [[ -n "$INSTANCE" ]]; then
    repoDir="${INSTANCE}_$repo"
  fi
  repoPath="$orgPath/$repoDir"
  if [[ ! -d $repoPath ]]; then
    mkdir -p $orgPath
    cd-if-necessary $orgPath
    if [[ $method == "http" ]]; then
      git clone https://$host/$org/$repo.git $repoDir
    else
      git clone git@$host:$org/$repo.git $repoDir
    fi
  fi
  cd-if-necessary $repoPath
}

# Set INSTANCE to work in a separate clone at ~/Documents/<host>/<org>/<INSTANCE>_<repo>
function set-instance() {
  if [[ -z "$1" ]]; then
    echo "Usage: set-instance <name>"
    return 1
  fi
  export INSTANCE="$1"
  # Stop oh-my-zsh overwriting the tab title on every prompt
  DISABLE_AUTO_TITLE=true
  printf '\e]1;%s\a\e]2;%s\a' "$INSTANCE" "$INSTANCE"
  
  # cd back to home so that we don't confusingly remain in another instance's repo
  cd ~/
}

function clear-instance() {
  unset INSTANCE
  unset DISABLE_AUTO_TITLE
}

function clone-and-cd-personal() {
  clone-and-cd ssh github.com $@
}

alias re-cd='cd "$(pwd)"'
