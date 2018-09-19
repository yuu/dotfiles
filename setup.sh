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
ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/dotfiles/git/gitignore ~/.gitignore
cp    ~/dotfiles/git/gitconfig.local ~/.gitconfig.local

# tmux
echo_blue link: tmux
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
git clone git://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# zsh
echo_blue link: zsh
mkdir -p ~/.config/zsh
ln -s $(pwd)/zsh/* ~/.config/zsh/
ln -s ~/.config/zsh/zshrc ~/.zshrc
git clone git://github.com/zsh-users/zaw.git ~/.config/zsh/zaw
git clone git://github.com/felixr/docker-zsh-completion.git ~/.config/zsh/docker

# emacs
echo_blue link: emacs
EMCONF="$HOME/.emacs.d"
mkdir -p $EMCONF
for i in $(command ls emacs.d); do echo $i; ln -s $(pwd)/emacs.d/$i $EMCONF/; done

# peco
echo_blue link: peco
ln -s $(pwd)/peco ~/.peco

# other
ln -s clang-format ~/.clang-format
ln -s rtorrent.rc ~/.rtorrent.rc
mkdir ~/.config/python
ln -s $(pwd)/pythonstartup ~/.config/python/pythonstartup
ln -s $(pwd)/screenrc ~/.screenrc

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
