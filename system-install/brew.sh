/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Ensure you do anything that brew has asked following installation"
echo "Press enter when complete"
read

brew update

brew tap homebrew/cask
brew tap homebrew/cask-fonts && brew install --cask font-source-code-pro
brew tap homebrew/cask-versions && brew install --cask java8
brew tap wix/brew

brew tap clementtsang/bottom && brew install bottom

brew install --cask 1password
brew install --cask adobe-creative-cloud
brew install --cask adoptopenjdk/openjdk/adoptopenjdk8
brew install --cask alfred
# brew install --cask android-platform-tools
# brew install --cask android-studio
# brew install --cask atom
brew install --cask avibrazil-rdm
brew install --cask burp-suite
brew install --cask charles
brew install --cask clocker
brew install --cask coconutbattery
brew install --cask colour-contrast-analyser
brew install --cask dash
brew install --cask docker
brew install --cask dropbox
brew install --cask figma
brew install --cask gifox
brew install --cask github
brew install --cask gitify
brew install --cask google-chrome
brew install --cask gpg-suite
# brew install --cask grandperspective
brew install --cask handbrake
brew install --cask homebrew/cask-versions/firefox-developer-edition
brew install --cask imageoptim
# brew install --cask intel-power-gadget
brew install --cask iterm2
brew install --cask meetingbar
brew install --cask nightowl
# brew install --cask nordvpn
brew install --cask oracle-jdk
brew install --cask postman
brew install --cask reflector
brew install --cask rocket
brew install --cask signal
brew install --cask sim-daltonism
# brew install --cask sketch
brew install --cask slack
brew install --cask soundflower
brew install --cask telegram
brew install --cask the-unarchiver
brew install --cask toggl-track
brew install --cask virtualbox
brew install --cask virtualbox-extension-pack
brew install --cask visual-studio-code
brew install --cask whatsapp
# brew install --cask parallels
brew install --cask vlc
brew install --cask homebrew/cask-drivers/canon-eos-utility
brew install ack # CLI search
brew install applesimutils # For detox testing
brew install bat
brew install broot
brew install chisel
brew install clang-format
brew install cloc # count lines of code
brew install cmake
brew install coreutils
brew install cowsay
brew install docker
brew install docker-compose
brew install duf
brew install exiftool
brew install git
brew install git-delta
brew install github/gh/gh
brew install glances
brew install gnupg gnupg2
brew install golang
brew install gpg gpg2 gnupg gnupg2
brew install htop
brew install httpie
brew install hub
brew install imagemagick
brew install imageoptim-cli
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
brew install redis
brew install sl
brew install swiftlint
brew install the_silver_searcher
brew install tree
brew install vim
brew install w3m
brew install watchman
brew install wget
brew install yarn
brew install zsh zsh-completions

brew unlink gnupg && brew link --overwrite gnupg2
