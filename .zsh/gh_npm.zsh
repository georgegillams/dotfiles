# ========================== NPM ==========================

alias npm-set-normal-registry='npm config set registry https://registry.npmjs.org/'
alias npm-upgrade-major-dependencies='npx npm-check-updates -u'
alias npm-upgrade-minor-dependencies='npx npm-check-updates -u --semverLevel major'
alias npm-upgrade-patch-dependencies='npx npm-check-updates -u --semverLevel minor'

alias npm-clear-cache='npm cache clean --force && npm cache clear --force && watchman watch-del-all && sudo rm -rf $TMPDIR/react-* && sudo rm -rf node_modules/'

alias yarn-upgrade='yarn set version stable'
alias yarn-linked="find . -type l | grep -v .bin | grep -v puppeteer | sed 's/^\.\/node_modules\///'"
alias yarn-unlink-all="rm -f .link && yarn-linked | xargs -I {} yarn unlink {} || true && yarn install --check-files"

function npx-update-browserlist-db() {
  yarnLockChangedSinceMain=$(git diff main --name-status | grep yarn.lock | cut -d\, -f1)

  if [ -n "$yarnLockChangedSinceMain" ]
  then
    npx -y update-browserslist-db@latest
  fi
}
