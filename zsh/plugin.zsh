# zaw

# notify
source $HOME/.config/zsh/behind-window-notify/behind-window-notify.zsh


export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
eval "$(fzf --zsh)"
