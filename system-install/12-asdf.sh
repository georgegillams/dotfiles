echo "nodejs 22.11.0" > ~/.tool-versions
open https://github.com/asdf-vm/asdf
mkdir -p $HOME/asdf/bin
open -p $HOME/asdf/bin
echo "Download ASDF and place binary in $HOME/asdf/bin"
echo "Download asdf.sh and place in $HOME/asdf/asdf.sh"
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add yarn https://github.com/twuni/asdf-yarn.git
