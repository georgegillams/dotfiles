/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

setup_type=$(cat ~/Desktop/setup_type.txt)

echo "Ensure you do anything that brew has asked following installation"
echo "If brew is asking you to do the following, just press return and it will be done for you."
echo "(echo; echo 'eval \"\$(/opt/homebrew/bin/brew shellenv)\"') >> /Users/george.gillams/.zprofile\neval \"\$(/opt/homebrew/bin/brew shellenv)\"\n\n"
echo "If brew is asking for something else, abort this script and edit it."
echo "Press enter to continue"
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
# brew install --cask coconutbattery
# brew install --cask fig
# brew install --cask grandperspective
# brew install --cask homebrew/cask-drivers/canon-eos-utility
# brew install --cask homebrew/cask-drivers/garmin-express
# brew install --cask keycastr
# brew install --cask meetingbar
# brew install --cask neat # github notifications
# brew install --cask oracle-jdk
# brew install --cask rode-central
# brew install --cask signal
# brew install --cask sim-daltonism
# brew install --cask soundflower
# brew install --cask telegram
# brew install --cask usr-sse2-rdm # for forcing monitor resolution
# brew install --cask wireshark
# brew install ack # CLI search
# brew install applesimutils # For detox testing
# brew install brightness
# brew install chisel
# brew install clang-format
# brew install cowsay
# brew install duf # disk usage
# brew install git-delta
# brew install glances
# brew install golang
# brew install lazydocker
# brew install lolcat
# brew install lynx
# brew install macvim
# brew install mitmproxy
# brew install procs
# brew install rbenv
# brew install rclone
# brew install sl
# brew install swiftlint
# brew install the_silver_searcher
# brew install w3m
brew install --cask 1password
brew install --cask bartender
brew install --cask daisydisk
brew install --cask figma
brew install --cask firefox@developer-edition
brew install --cask google-chrome
brew install --cask google-drive
brew install --cask gpg-suite
brew install --cask handbrake
brew install --cask imageoptim
brew install --cask iterm2
brew install --cask microsoft-excel
brew install --cask microsoft-word
brew install --cask raycast
brew install --cask rectangle-pro
brew install --cask rocket
brew install --cask the-unarchiver
brew install --cask ticktick
brew install --cask topaz-photo-ai
brew install --cask visual-studio-code
brew install --cask vlc
brew install --cask whatsapp
brew install 1password-cli
brew install bat
brew install cloc # count lines of code
brew install coreutils
brew install duti
brew install exiftool # photo meta-data editing
brew install ffmpeg
brew install gh
brew install git
brew install gnupg gnupg2
brew install gpg gpg2 gnupg gnupg2
brew install htop
brew install imagemagick
brew install imageoptim-cli
brew install mas # CLI apps store
brew install nvm
brew install python3
brew install redis
brew install switchaudio-osx
brew install tree
brew install vim
brew install wget
brew install yarn
brew install zsh zsh-completions

if [[ $setup_type == "WORK" ]]; then
  brew install --cask aws-vpn-client
  brew install --cask betterdisplay
  brew install --cask charles
  brew install --cask docker
  brew install --cask notion
  brew install --cask postman
  brew install --cask screen-studio
  brew install --cask slack
  brew install awscli
  brew install cmake
  brew install cookiecutter
  brew install docker
  brew install docker-compose
  brew install jq # needed for tf-cli
  brew install kubectx
  brew install kubernetes-cli
  brew install libpq && brew link --force libpq # postgresql
  brew install siege
  brew install tmux
  brew install watchman
fi

if [[ $setup_type == "PERSONAL" ]]; then
  brew install --cask displaylink
  brew install --cask jellyfin
  brew install --cask makemkv
  brew install --cask mechvibes
  brew install --cask utm
  brew install libdvdcss
fi

brew unlink gnupg && brew link --overwrite gnupg2
