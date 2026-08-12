. ./00-setup-type.sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Ensure you do anything that brew has asked following installation"
echo "Press enter to continue"
read

brew update

brew install --cask figma
brew install --cask firefox
brew install --cask google-chrome
brew install --cask iterm2
brew install --cask obsidian
brew install --cask raycast
brew install --cask rectangle-pro
brew install --cask vlc
brew install coreutils
brew install gh
brew install starship
brew install vim
brew install wget
brew install zsh

if [[ $setup_type == *"WORK"* ]]; then
fi

if [[ $setup_type == "WORK_SETUP_PROFILE_HS" ]]; then
fi

if [[ $setup_type == "PERSONAL_SETUP_PROFILE_1" ]]; then
  brew install --cask 1password
  brew install --cask coconutbattery
  brew install --cask cursor
  brew install --cask daisydisk
  brew install --cask docker
  brew install --cask elgato-stream-deck
  brew install --cask google-drive
  brew install --cask gpg-suite
  brew install --cask handbrake
  brew install --cask imageoptim
  brew install --cask makemkv
  brew install --cask microsoft-excel
  brew install --cask microsoft-word
  brew install --cask postman
  brew install --cask rocket
  brew install --cask rode-central
  brew install --cask screen-studio
  brew install --cask sim-daltonism
  brew install --cask slack
  brew install --cask the-unarchiver
  brew install --cask ticktick
  brew install --cask topaz-photo-ai
  brew install --cask utm
  brew install --cask whatsapp
  brew install --cask wireshark
  brew install 1password-cli
  brew install asdf
  brew install bat
  brew install blackhole-16ch
  brew install cloc # count lines of code
  brew install coreutils
  brew install curl
  brew install docker
  brew install docker-compose
  brew install duti
  brew install exiftool # photo meta-data editing
  brew install ffmpeg
  brew install fswatch
  brew install fzf # fuzzy finder for CLI tab completion
  brew install git
  brew install gnupg
  brew install htop
  brew install imagemagick
  brew install imageoptim-cli
  brew install iperf3
  brew install kubectx
  brew install kubernetes-cli
  brew install lazydocker
  brew install libdvdcss
  brew install mas # CLI apps store
  brew install mitmproxy
  brew install neovim
  brew install nvm
  brew install python@3.11
  brew install redis
  brew install rtk
  brew install sox
  brew install swiftlint
  brew install switchaudio-osx
  brew install the_silver_searcher
  brew install tmux
  brew install tree
  brew install yarn
fi

if [[ $setup_type == "WORK_SETUP_PROFILE_TF" ]]; then
  brew install --cask aws-vpn-client
  brew install --cask betterdisplay
  brew install --cask charles
  brew install --cask docker
  brew install --cask elgato-stream-deck
  brew install --cask notion
  brew install --cask postman
  brew install --cask screen-studio
  brew install --cask slack
  brew install awscli
  brew install claude
  brew install cmake
  brew install cookiecutter
  brew install docker
  brew install docker-compose
  brew install docker-credential-helper-ecr
  brew install gofumpt
  brew install golangci-lint
  brew install jq # needed for tf-cli
  brew install kubectx
  brew install kubernetes-cli
  brew install lazydocker
  brew install libpq && brew link --force libpq # postgresql
  brew install postgresql@16
  brew install siege
  brew install tmux
  brew install watchman
fi

# Not currently used, but useful apps to have in the future

# brew tap homebrew/cask
# brew tap homebrew/cask-fonts && brew install --cask font-source-code-pro
# brew tap homebrew/cask-versions && brew install --cask java8
# brew tap clementtsang/bottom && brew install bottom # graphical process/system monitor. Run with `btm`
# brew tap jakehilborn/jakehilborn && brew install displayplacer
# brew tap samwho/spacer && brew install spacer # improved terminal output for long-running commands

# brew install --cask adoptopenjdk/openjdk/adoptopenjdk8
# brew install --cask bartender
# brew install --cask burp-suite
# brew install --cask displaylink
# brew install --cask fig
# brew install --cask grandperspective
# brew install --cask homebrew/cask-drivers/canon-eos-utility
# brew install --cask homebrew/cask-drivers/garmin-express
# brew install --cask jellyfin
# brew install --cask keycastr
# brew install --cask mechvibes
# brew install --cask meetingbar
# brew install --cask neat # github notifications
# brew install --cask oracle-jdk
# brew install --cask signal
# brew install --cask soundflower # redirect audio before blackhole
# brew install --cask telegram
# brew install --cask usr-sse2-rdm # for forcing monitor resolution
# brew install --cask visual-studio-code
# brew install ack # CLI search
# brew install applesimutils # For detox testing
# brew install audiowaveform
# brew install brightness
# brew install chisel
# brew install clang-format
# brew install cowsay
# brew install duf # disk usage
# brew install git-delta
# brew install glances
# brew install golang
# brew install lolcat
# brew install lynx
# brew install macvim
# brew install procs
# brew install rbenv
# brew install rclone
# brew install sl
# brew install w3m
