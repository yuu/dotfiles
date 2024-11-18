#!/bin/bash
#----------------------------------------------------------------------------#
# function                                                                   #
#----------------------------------------------------------------------------#
function echo_error() { echo -e "\e[2;31m$*\e[m"; }
function echo_success() { echo -e "\e[2;32m$*\e[m"; }
function echo_blue() { echo -e "\e[2;34m$*\e[m"; }

#----------------------------------------------------------------------------#
# dotfiles                                                                   #
#----------------------------------------------------------------------------#
# git
echo_blue link: git
mkdir -p ~/.config/git
ln -fs ~/dotfiles/git/config ~/.config/git/config
ln -fs ~/dotfiles/git/ignore ~/.config/git/ignore
cp    ~/dotfiles/git/config.local ~/.config/git/config.local
ln -fs ~/dotfiles/git/message.txt ~/.config/git/message.txt

# tmux
echo_blue link: tmux
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
git clone git://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# zsh
echo_blue link: zsh
mkdir -p ~/.config/zsh
ln -s $(pwd)/zsh/* ~/.config/zsh/
ln -s ~/.config/zsh/zshrc.zsh ~/.zshrc
git clone --depth 1 https://github.com/zsh-users/zaw.git ~/.config/zsh/zaw
curl -fLo ~/.config/zsh/func/_docker https://raw.github.com/felixr/docker-zsh-completion/master/_docker

# emacs
echo_blue link: emacs
EMCONF="$HOME/.emacs.d"
mkdir -p $EMCONF/straight
for i in $(command ls emacs.d |grep -v versions); do echo $i; ln -s $(pwd)/emacs.d/$i $EMCONF/; done
ln -s $(pwd)/emacs.d/versions $EMCONF/straight

# terminal
ALACONF=$HOME/.config/alacritty
mkdir -p $ALACONF
ln -s $(pwd)/config/alacritty/alacritty.toml $ALACONF

ln -s $(pwd)/config/wezterm $HOME/config/wezterm

# other
ln -s $(pwd)/peco ~/.config/peco
ln -s $(pwd)/clang-format ~/.clang-format
ln -s $(pwd)/rtorrent.rc ~/.rtorrent.rc
mkdir ~/.config/python
ln -s $(pwd)/pythonstartup ~/.config/python/pythonstartup
ln -s $(pwd)/screenrc ~/.screenrc
ln -s $(pwd)/editorconfig ~/.editorconfig

if [ "$(uname)" == 'Darwin' ]; then
    KD=$HOME/.config/karabiner
    mkdir -p $KD
    ln -s ~/dotfiles/karabiner.json $KD
    ln -s ~/dotfiles/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
else
    TC=~/.config/terminator
    mkdir -p $TC
    ln -s ~/dotfiles/terminator/config $TC/
fi
echo_success success
