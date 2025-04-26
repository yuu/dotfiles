export TERM=xterm-256color
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_COLLATE=C
export HOMEBREW_NO_INSTALL_CLEANUP=1
export CUCUMBER_PUBLISH_ENABLED=false
export CUCUMBER_PUBLISH_QUIET=true
export GOPATH=$HOME/.local
export GPG_TTY=`tty`

# python
export PYTHONSTARTUP=~/.config/python/pythonstartup

path=(~/.local/bin(N-/) /usr/local/bin(N-/) /usr/local/sbin(N-/) ${path})
fpath=(~/.config/zsh/func(N-/) ~/.config/zsh/completions(N-/) ${fpath})
