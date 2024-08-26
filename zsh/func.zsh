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
  export AWS_PROFILE=$(cat $HOME/.aws/config |ggrep -Po '(?<=profile ).*(?=\])' |fzf)
}

fd-peco-files() {
    selection=$(fd --type f --type d . | peco)

    if [[ -n "$selection" ]]; then
        LBUFFER+="${(q)selection}"
        zle redisplay
    fi
}

zle -N fd-peco-files
bindkey '^o' fd-peco-files

get-ip-me() {
    curl http://checkip.amazonaws.com
}
