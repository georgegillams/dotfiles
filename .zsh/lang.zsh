# ========================= CLANG =========================

alias clang-all-the-things='clang-format -i **/*.h **/*.m **/*.mc'

# ========================= XCODE =========================

alias xcode='open'
alias xcode-delete-derived-data='rm -rf ~/Library/Developer/Xcode/DerivedData/ && mkdir ~/Library/Developer/Xcode/DerivedData'
alias xcode-fix-AST-error='rm -rf ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex'
alias simulator-reset-all-devices='(pkill Simulator || true) && xcrun simctl erase all'
alias be='bundle exec'

# ========================= ANDROID =========================

alias AndroidStudio="open -a /Applications/Android\ Studio.app"

# ========================= REDIS =========================

alias redis-reset='redis-cli flushall && redis-cli flushall && redis-cli flushall && redis-cli flushall && redis-cli flushall'
