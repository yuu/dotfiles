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

function fzf-cdr() {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | fzf --reverse)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N fzf-cdr
bindkey "^[r" fzf-cdr

function fzf-select-history() {
    BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER" --reverse)
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history

sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
    zle end-of-line                 # move cursor to end-of-line
}
zle -N sudo-command-line
bindkey "\e\e" sudo-command-line    # [Esc] [Esc]

function confirm() {
  echo -n "Run '$*'? [y/N] "
  read -q && echo "" && "$@" || echo "Canceled"
}
