# zaw

# notify
source $HOME/.config/zsh/behind-window-notify/behind-window-notify.zsh

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#d0d0d0,fg+:#3D4258,bg:-1,bg+:#74A8DF
  --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00
  --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf
  --color=gutter:#d0d0d0,border:#262626,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="$ "
  --marker=">" --pointer=">" --separator="─" --scrollbar="│"
  --layout="reverse"'
source <(fzf --zsh)
