export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export TERM=xterm-256color
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_COLLATE=C
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_AUTO_UPDATE=1
export CUCUMBER_PUBLISH_ENABLED=false
export CUCUMBER_PUBLISH_QUIET=true
export GOPATH=$HOME/.local
export GPG_TTY=`tty`

# python
export PYTHONSTARTUP=~/.config/python/pythonstartup

path=(~/.local/bin(N-/) /opt/homebrew/bin(N-/) /opt/homebrew/sbin(N-/) /usr/local/sbin(N-/) ${path})
fpath=(~/.config/zsh/func(N-/) ~/.config/zsh/completions(N-/) /opt/homebrew/share/zsh-completions(N-/) /opt/homebrew/share/zsh/site-functions(N-/) ${fpath})
