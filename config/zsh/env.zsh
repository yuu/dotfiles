export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"

export TERM=xterm-256color
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_COLLATE=C

export CUCUMBER_PUBLISH_ENABLED=false
export CUCUMBER_PUBLISH_QUIET=true

export GOPATH=$HOME/.local

export GPG_TTY=`tty`

export MIGEMO_DICT=/run/current-system/sw/share/migemo/utf-8/migemo-dict

# python
export PYTHONSTARTUP=~/.config/python/pythonstartup

path=(~/.local/bin(N-/) /usr/local/sbin(N-/) ${path})
fpath=(~/.config/zsh/func(N-/) ~/.config/zsh/completions(N-/) ${fpath})
