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
mkdir ~/.vim
ls -l vim |awk '{print $9}' |xargs -i ln -s "`pwd`/vim/{}" ~/.vim/

# peco
ln -s $(pwd)/peco ~/.peco

# other
mkdir ~/.config/python
ln -s $(pwd)/pythonstartup ~/.config/python/pythonstartup
ln -s $(pwd)/screenrc ~/.screenrc

if [ "$(uname)" == 'Darwin' ]; then
    ln -s ~/dotfiles/karabiner-private.xml ~/Library/Application\ Support/Karabiner/private.xml
    ln -s ~/dotfiles/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
else
    mkdir -p ~/.config/terminator
    ln -s ~/dotfiles/terminator/config ~/.config/terminator/
fi
echo_success success
