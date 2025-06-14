alias gh-prs='gh pr list'
alias gh-check-if-pr-exists='gh pr view > /dev/null'
alias gh-create-pr='gh pr create'
alias IMPLEMENTATION-gh-create-pr-web='gh pr create --web'
alias IMPLEMENTATION-gh-view-pr-web='gh pr view --web'
function gh-view-or-create-pr-web() {
  # If a PR exists, open it:
  IMPLEMENTATION-gh-view-pr-web
  if [[ $? != 0 ]] then;
    # If a PR didn't exist, create it:
    IMPLEMENTATION-gh-create-pr-web
  fi;
}

function gh-create-pr-web-if-none() {
  # check if a PR exists
  gh-check-if-pr-exists
  if [[ $? != 0 ]] then;
    # If a PR didn't exist, create it:
    IMPLEMENTATION-gh-create-pr-web
  fi;
}

alias IMPLEMENTATION-gh-cancel-pr-jobs='node ~/Documents/georgegillams/dotfiles/gh-cancel-jobs.js'
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
alias git-prepend-branch-name='node ~/Documents/georgegillams/dotfiles/prepend-ticket.js'
alias git-rebase-keep-their-changes='git checkout --ours . && git add . && git rebase --continue'
alias git-rebase-keep-our-changes='git checkout --theirs . && git add . && git rebase --continue'
alias IMPLEMENTATION-git-main-latest='gco main && git-fetch && git reset --hard origin/main && git pull && (git branch -D $(git branch | grep -v "main") || true) && git submodule update && git reset --hard HEAD && git reset --recurse-submodules'
alias IMPLEMENTATION-git-master-latest='gco master && git-fetch && git reset --hard origin/master && git pull && (git branch -D $(git branch | grep -v "master") || true) && git submodule update && git reset --hard HEAD && git reset --recurse-submodules'
alias gml='if [[ $(pwd) == *"Documents/Typeform/terraform-shared"* ]]; then IMPLEMENTATION-git-master-latest; elif [[ $(pwd) == *"Documents/Typeform/k8s-manifests"* ]]; then IMPLEMENTATION-git-master-latest; else IMPLEMENTATION-git-main-latest; fi'
alias gaa-no-image-optimisation='git add .'
alias gaa='git-pre-push && gaa-no-image-optimisation && node ~/Documents/georgegillams/dotfiles/image-optim.js && gaa-no-image-optimisation'
alias git-reset='red "ABOUT TO CLEAR ALL CHANGES\nTHATS ALL CHANGES\nALL OF THEM" && git-pre-push && gaa-no-image-optimisation && git reset --hard HEAD && git reset --recurse-submodules'
alias git-reset-unstaged='yellow "ABOUT TO CLEAR UNSTAGED CHANGES\nUNSTAGED CHANGES WILL BE GONE\nALSO NEW FILES THAT ARENT STAGED" && git-pre-push && git checkout -- .'
alias git-fetch='git fetch --all'
alias IMPLEMENTATION-git-rebase-main='git-fetch && (git rebase origin/main | grep CONFLICT || true) && git-submodules-pull'
alias IMPLEMENTATION-git-rebase-master='git-fetch && (git rebase origin/master | grep CONFLICT || true) && git-submodules-pull'
alias grm='if [[ $(pwd) == *"Documents/Typeform/terraform-shared"* ]]; then IMPLEMENTATION-git-rebase-master; elif [[ $(pwd) == *"Documents/Typeform/k8s-manifests"* ]]; then IMPLEMENTATION-git-rebase-master; else IMPLEMENTATION-git-rebase-main; fi'
alias gri='git rebase -i'
alias git-pull-master-from-upstream='echo "ensure upstream is set using \"git remote add upstream URL\"" && git fetch upstream && git merge upstream/master && git remote remove upstream && git push origin origin/master'
alias git-pull-main-from-upstream='echo "ensure upstream is set using \"git remote add upstream URL\"" && git fetch upstream && git merge upstream/main && git remote remove upstream && git push origin origin/main'
alias git-pre-push='git status && sleep 3'
alias git-rename-last-commit='git commit --amend --no-verify'
alias gamp='git-pre-push && gcn! --no-verify && gpf'
alias gamp-with-verification='git-pre-push && gcn! && gpf-with-verification'
alias git-test-amend-push='fixtest && git add . && gitamendpush'
alias gpf-with-verification='ggf && git push --no-verify --set-upstream $(git remote) $(git branch | grep \* | cut -d " " -f2)'
alias gpf='git push --force --no-verify && gh-create-pr-web-if-none'
alias git-yolo='gpf'
alias git-clear-cache='git rm -r --cached . && git add . && git commit -m && git push ~'
function gcmpWithType() { git-pre-push && git commit -m "$(git-prepend-branch-name $@)" --no-verify && gpf }
function gcmpfix() { gcmpWithType $@ fix }
function gcmpfeat() { gcmpWithType $@ feat }
function gcmpchore() { gcmpWithType $@ chore }
function gcmpdocs() { gcmpWithType $@ docs }
function gcmpbreaking() { git-pre-push && git commit -m "$(git-prepend-branch-name $@ feat !)" -m "BREAKING CHANGE: $@" --no-verify && gpf }
function IMPLEMENTATION-git-revert-to-main() { rm -rf $@ && git checkout origin/main $@ }
function IMPLEMENTATION-git-revert-to-master() { rm -rf $@ && git checkout origin/master $@ }
function git-revert-to-main() { if [[ $(pwd) == *"Documents/Typeform/terraform-shared"* ]]; then IMPLEMENTATION-git-revert-to-master $@ ; elif [[ $(pwd) == *"Documents/Typeform/k8s-manifests"* ]]; then IMPLEMENTATION-git-revert-to-master $@ ; else IMPLEMENTATION-git-revert-to-main $@ ; fi }
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
alias git-pull-fork='node ~/Documents/georgegillams/dotfiles/pull-forked-branch.js'
alias git-submodules-init='git submodule update --init --recursive'
alias git-submodules-pull='git submodule update --recursive --remote'
alias git-disable-gpg='(git config --global commit.gpgsign false && git config --global tag.forceSignAnnotated false && git config --global --unset gpg.program) || true'
alias git-enable-gpg='git config --global commit.gpgsign true && git config --global tag.forceSignAnnotated true && git config --global gpg.program gpg'

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
  orgPath="$HOME/Documents/$1"
  repoPath="$orgPath/$2"
  if [[ ! -d $repoPath ]]; then
    mkdir -p $orgPath
    cd-if-necessary $orgPath
    git clone git@github.com:$1/$2.git
  fi
  cd-if-necessary $repoPath
}

alias re-cd='cd "$(pwd)"'
