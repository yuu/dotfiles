function echo_error() { echo -e "\e[2;31m$*\e[m"; }
function echo_success() { echo -e "\e[2;32m$*\e[m"; }
function echo_blue() { echo -e "\e[2;34m$*\e[m"; }

if ! which git > /dev/null 2>&1; then
    echo_error git command not found
    exit 1
fi

echo_blue git clone dotfile from github.com
git clone --origin upstream https://github.com/yuu/dotfiles.git ~/dotfiles

echo_blue setup dotfiles
cd ~/dotfiles
./setup.sh
