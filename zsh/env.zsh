# https://nemoplus.hateblo.jp/entry/20090119/1232373540
export LSCOLORS=exfxcxdxcxexbxabagacad
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 色
export TERM=xterm-256color

export GPG_TTY=`tty`

# python
export PYTHONSTARTUP=~/.config/python/pythonstartup

export GOPATH=$HOME/.local
path=(~/.local/bin(N-/) /usr/local/bin(N-/) /usr/local/sbin(N-/) ${path})


export LANG=en_US.UTF-8
export HOMEBREW_NO_INSTALL_CLEANUP=1
