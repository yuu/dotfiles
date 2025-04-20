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
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}

# git
echo_blue link: git
A=~/dotfiles/git
B=$XDG_CONFIG_HOME/git
mkdir -p $B
ln -fs $A/config $B/config
ln -fs $A/ignore $B/ignore
ln -fs $A/message.txt $B/message.txt
if [ ! -e $B/config.local ]; then
    cp $A/config.local $B/config.local
fi

# zsh
echo_blue link: zsh
A=~/dotfiles/zsh
B=$XDG_CONFIG_HOME/zsh
mkdir -p $B
ln -s $A/* $B/
ln -s $B/zshrc.zsh ~/.zshrc

# emacs
echo_blue link: emacs
A=~/dotfiles/emacs.d
B=~/.emacs.d
mkdir -p $B/straight
for i in $(command ls emacs.d |grep -v versions); do echo $i; ln -s $A/$i $B/; done
ln -s $A/versions $B/straight

# terminal
A=~/dotfiles/wezterm
B=$XDG_CONFIG_HOME/wezterm
ln -s $A $B

# yazi
A=~/dotfiles/yazi
B=$XDG_CONFIG_HOME/yazi
ln -s $A $B

# other
A=~/dotfiles
ln -s $A/peco $XDG_CONFIG_HOME/peco
ln -s $A/rtorrent.rc ~/.rtorrent.rc
ln -s $A/screenrc ~/.screenrc
ln -s $A/editorconfig ~/.editorconfig

if [ "$(uname)" == 'Darwin' ]; then
    B=$XDG_CONFIG_HOME/karabiner
    mkdir -p $B
    ln -s $A/karabiner.json $B
fi

echo_success success
