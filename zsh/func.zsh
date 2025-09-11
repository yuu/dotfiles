function ghq-list() {
    local selected_dir=$(ghq list | fzf --query "$LBUFFER")
    local root_dir=$(ghq root)
    if [ -n "$selected_dir" ]; then
        BUFFER=" cd $root_dir/${selected_dir}"
        zle accept-line
    else
        zle redisplay
    fi
}
zle -N ghq-list
bindkey '^xl' ghq-list

function confirm() {
  echo -n "Run '$*'? [y/N] "
  read -q && echo "" && "$@" || echo "Canceled"
}
