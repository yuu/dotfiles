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
echo_blue link: dotfiles
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/gitignore ~/.gitignore
cp    ~/dotfiles/gitconfig.local ~/.gitconfig.local
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/zsh ~/.zsh
ln -s ~/dotfiles/tmux ~/.tmux
git clone git://github.com/zsh-users/zaw.git ~/dotfiles/zsh/zaw/
git clone git://github.com/tmux-plugins/tpm ~/dotfiles/tmux/tpm/

if [ "$(uname)" == 'Darwin' ]; then
    ln -s ~/dotfiles/karabiner-private.xml ~/Library/Application\ Support/Karabiner/private.xml
    ln -s ~/dotfiles/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
fi
echo_success success
