# grpe
dgrep(){
    if [ $# -eq 1 ]; then
        egrep --color=auto -Hnr "$1"
    elif [ $# -eq 2 ]; then
        egrep --color=auto -Hn "$1" -- **/*.$2
    fi
}
pgrep() {
    local cmd=""
    if [ $# -eq 1 ]; then
        cmd="egrep --color=auto -Hnr '$1' |peco"
    elif [ $# -eq 2 ]; then
        cmd="egrep --color=auto -Hnr '$1' **/*.$2 |peco"
    fi
    if [ -n "$cmd" ]; then
        ret=$(eval "$cmd")
        if [ -n "$ret" ]; then
            file=$(echo "$ret" |grep -Po '.+?(?=:\d{1,}:)')
            line=$(echo "$ret" |grep -Po '(?<=:)[0-9]{1,}(?=:)')
            nvim "$file" -c $line
        fi
    fi
}

# mac app execute
run(){
    $1/Contents/MacOS/$(basename $1 .app)
}

xcode-switch() {
    sudo xcode-select --switch $1/Contents/Developer
}

sdmount() {
    img=$1
    pos=$2
    sector=$3
    partitionStart=$4

    mount -o loop,offset=$(expr ${partitionStart} \* ${sector}) ${img} ${pos}
}

remake(){
    make clean
    if [ $? -eq 0 ]; then
        if [ $# -eq 0 ]; then
            make -j$(nproc)
        elif [ $# -eq 1 ]; then
            make $1
        fi
    fi
}

function ghq-list() {
    local selected_dir=$(ghq list | peco --query "$LBUFFER")
    local root_dir=$(ghq root)
    if [ -n "$selected_dir" ]; then
        BUFFER=" cd $root_dir/${selected_dir}"
        zle accept-line
    fi
}
zle -N ghq-list
bindkey '^xl' ghq-list

function dropbox-list() {
    export GHQ_ROOT="$HOME/Dropbox/src"
    local selected_dir=$(ghq list | peco --query "$LBUFFER")
    local root_dir=$(ghq root)
    if [ -n "$selected_dir" ]; then
        BUFFER=" cd $root_dir/${selected_dir}"
        zle accept-line
    fi
    unset GHQ_ROOT
}
zle -N dropbox-list
bindkey '^x^l' dropbox-list

function ghqd() {
    export GHQ_ROOT="$HOME/Dropbox/src"
    ghq $@
    unset GHQ_ROOT
}

function proj-list() {
    local root_dir="$HOME/projects"
    if [ ! -d "$root_dir" ]; then
        return
    fi
    local selected_dir="$(cd $root_dir; find . -maxdepth 4 -type d ! -path "*/.*"| sort | uniq | peco)"
    if [ -n "$selected_dir" ]; then
        BUFFER=" cd $root_dir/${selected_dir}"
        zle accept-line
    fi
}
zle -N proj-list
bindkey '^xp' proj-list

function zsh-select-history() {
    BUFFER=$(fc -l -r -n 1 | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N zsh-select-history
bindkey '^[r' zsh-select-history

function peco-dfind() {
    local selected_dir="$(find . -maxdepth 10 -type f ! -path "*/.*"| sort | peco)"
    BUFFER="${LBUFFER}${selected_dir}"
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-dfind
bindkey '^xf' peco-dfind

# rpm
rpmcat() {
    rpm2cpio $1 | cpio -idv
}

rpmshow() {
    rpm -qlp $1
}

resolve-name() {
    ping -c 1 $1 |head -n 1 |grep -Po '(?<=\()\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}(?=\))'
}

pyhttpserver() {
    local port=${1:-8080}
    python -m http.server $port
}

lssh() {
    ssh $(cat ~/.ssh/config |grep -Po "(?<=Host ).*" |grep -v "\*"| peco)
}

aws-switch-profile() {
  export AWS_PROFILE=$(cat $HOME/.aws/config |ggrep -Po '(?<=profile ).*(?=\])' |peco)
}
