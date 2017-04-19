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
# git
ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/dotfiles/git/gitignore ~/.gitignore
cp    ~/dotfiles/git/gitconfig.local ~/.gitconfig.local

# tmux
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
git clone git://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# zsh
mkdir -p ~/.config/zsh
ln -s $(pwd)/zsh/* ~/.config/zsh/
ln -s ~/.config/zsh/zshrc ~/.zshrc
git clone git://github.com/zsh-users/zaw.git ~/.config/zsh/zaw

# vim
VIM="$HOME/.config/nvim"
mkdir -p $VIM
for i in $(command ls nvim |grep -v local); do echo $i; ln -s $(pwd)/nvim/$i $VIM/; done

# peco
ln -s $(pwd)/peco ~/.peco

# other
mkdir ~/.config/python
ln -s $(pwd)/pythonstartup ~/.config/python/pythonstartup
ln -s $(pwd)/screenrc ~/.screenrc

if [ "$(uname)" == 'Darwin' ]; then
    KD=$HOME/.config/karabiner
    mkdir -p $KD
    ln -s ~/dotfiles/karabiner.json $KD
    ln -s ~/dotfiles/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
else
    mkdir -p ~/.config/terminator
    ln -s ~/dotfiles/terminator/config ~/.config/terminator/
fi
echo_success success
