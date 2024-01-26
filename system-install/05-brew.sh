/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Ensure you do anything that brew has asked following installation"
echo "Press enter when complete"
read

# Note: These commands are instructions from the brew install process which may change in the future.
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/george.gillams/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew update

# brew tap homebrew/cask
brew tap homebrew/cask-fonts && brew install --cask font-source-code-pro
# brew tap homebrew/cask-versions && brew install --cask java8
brew tap wix/brew

brew tap clementtsang/bottom && brew install bottom # graphical process/system monitor. Run with `btm`
brew tap jakehilborn/jakehilborn && brew install displayplacer
brew tap samwho/spacer && brew install spacer # improved terminal output for long-running commands

# brew install --cask adoptopenjdk/openjdk/adoptopenjdk8
# brew install --cask burp-suite
# brew install --cask fig
# brew install --cask github
# brew install --cask grandperspective
# brew install --cask homebrew/cask-drivers/canon-eos-utility
# brew install --cask meetingbar
# brew install --cask oracle-jdk
# brew install --cask rode-central
# brew install --cask signal
# brew install --cask soundflower
# brew install --cask spectacle
# brew install --cask telegram
# brew install --cask wireshark
# brew install applesimutils # For detox testing
brew install --cask 1password
brew install --cask 1password/tap/1password-cli
brew install --cask aws-vpn-client
brew install --cask bartender
brew install --cask charles
brew install --cask coconutbattery
brew install --cask daisydisk
brew install --cask docker
brew install --cask figma
brew install --cask gh
brew install --cask google-chrome
brew install --cask google-drive
brew install --cask gpg-suite
brew install --cask handbrake
brew install --cask homebrew/cask-drivers/garmin-express
brew install --cask homebrew/cask-versions/firefox-developer-edition
brew install --cask imageoptim
brew install --cask iterm2
brew install --cask keycastr
brew install --cask microsoft-excel
brew install --cask microsoft-word
brew install --cask neat # github notifications
brew install --cask postman
brew install --cask raycast
brew install --cask rectangle-pro
brew install --cask rocket
brew install --cask screen-studio
brew install --cask sim-daltonism
brew install --cask slack
brew install --cask the-unarchiver
brew install --cask ticktick
brew install --cask timing
brew install --cask usr-sse2-rdm # for forcing monitor resolution
brew install --cask visual-studio-code
brew install --cask vlc
brew install --cask whatsapp
brew install ack # CLI search
brew install awscli
brew install bat
brew install brightness
brew install chisel
brew install clang-format
brew install cloc # count lines of code
brew install cmake
brew install cookiecutter
brew install coreutils
brew install cowsay
brew install docker
brew install docker-compose
brew install duf # disk usage
brew install duti
brew install exiftool # photo meta-data editing
brew install git
brew install git-delta
brew install github/gh/gh
brew install glances
brew install gnupg gnupg2
brew install golang
brew install gpg gpg2 gnupg gnupg2
brew install htop
brew install imagemagick
brew install imageoptim-cli
brew install jq # needed for tf-cli
brew install kubectx
brew install kubernetes-cli kubectx
brew install lazydocker
brew install libdvdcss
brew install lolcat
brew install lynx
brew install macvim
brew install mas # CLI apps store
brew install mitmproxy
brew install nvm
brew install procs
brew install python3
brew install rbenv
brew install rclone
brew install redis
brew install sl
brew install swiftlint
brew install switchaudio-osx
brew install the_silver_searcher
brew install tree
brew install vim
brew install w3m
brew install watchman
brew install wget
brew install yarn
brew install zsh zsh-completions

brew unlink gnupg && brew link --overwrite gnupg2
