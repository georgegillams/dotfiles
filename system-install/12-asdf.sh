. ./00-setup-type.sh

if [[ $setup_type == "PERSONAL_SETUP_PROFILE_1" ]]; then
    echo "nodejs 22.11.0" > ~/.tool-versions
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    asdf plugin add yarn https://github.com/twuni/asdf-yarn.git
fi
