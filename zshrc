#------ zsh ------#
#PRONPT
PS1="[@${HOST%%.*} %1~]%(!.#.$) "

# LS_COLORSを設定しておく
export LS_COLORS='di=01;34:ln=01;35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34'

# 色
export TERM=xterm-256color

#RPROMPT="%T"                      # 右側に時間を表示する
setopt transient_rprompt          # 右側まで入力がきたら時間を消す

autoload -U compinit
compinit

HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000

bindkey -e
bindkey '^W' kill-region
# 複数の zsh を同時に使う時など history ファイルに上書きせず追加
setopt append_history
# シェルのプロセスごとに履歴を共有
setopt share_history
# 履歴ファイルに時刻を記録
setopt extended_history
# history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store
# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups
# 重複したヒストリは追加しない
setopt hist_ignore_all_dups
# incremental append
setopt inc_append_history

# ディレクトリ名だけで､ディレクトリの移動をする｡
setopt auto_cd
# cdのタイミングで自動的にpushd
setopt auto_pushd
setopt pushd_ignore_dups


# 補完候補が複数ある時に、一覧表示
setopt auto_list
# 補完キー（Tab, Ctrl+I) を連打するだけで順に補完候補を自動で補完
setopt auto_menu
# ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob
# C-s, C-qを無効にする。
setopt NO_flow_control
# 8 ビット目を通すようになり、日本語のファイル名を表示可能
setopt print_eight_bit
# カッコの対応などを自動的に補完
setopt auto_param_keys
# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
# 最後がディレクトリ名で終わっている場合末尾の / を自動的に取り除く
setopt auto_remove_slash
# {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl
# コマンドのスペルチェックをする
setopt correct
# =command を command のパス名に展開する
setopt equals
# シェルが終了しても裏ジョブに HUP シグナルを送らないようにする
setopt NO_hup
# Ctrl+D では終了しないようになる（exit, logout などを使う）
setopt ignore_eof
# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments
# auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示しない
setopt list_types
# 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs
# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst
# ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs
# 複数のリダイレクトやパイプなど、必要に応じて tee や cat の機能が使われる
setopt multios
# ファイル名の展開で、辞書順ではなく数値的にソートされるようになる
setopt numeric_glob_sort
# for, repeat, select, if, function などで簡略文法が使えるようになる
setopt short_loops
#コピペの時rpromptを非表示する
setopt transient_rprompt
# 文字列末尾に改行コードが無い場合でも表示する
unsetopt promptcr
# リダイレクトでファイルを消さない
setopt no_clobber
# 補完候補をpack
setopt list_packed

# すごいプロンプト
setopt prompt_subst
autoload -U colors; colors

#ターミナルのタイトル設定
case "${TERM}" in
mlterm|kterm*|xterm*)
    titlechange(){
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
screen*)
    titlechange(){
        echo -ne "\033P\033]0;${USER}@${HOST%%.*}:${PWD}\007\033\\"
    }
    ;;
*)
    titlechange(){
    }
    ;;
esac

# 履歴検索設定
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# ブランチ名表示
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
repinfo(){
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}


precmd () {
    repinfo
    titlechange
}
# バージョン管理されているディレクトリにいれば表示，そうでなければ非表示
RPROMPT="%1(v|%F{green}%1v%f|)"

export GPG_TTY=`tty`

# tty start/stop shortcut
stty stop  undef #C-s
stty start undef #C-q

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

#------ zaw ------#
source $HOME/.zsh/zaw/zaw.zsh (N-/)
bindkey '^xb' zaw-cdr
bindkey '^r' zaw-history
bindkey '^x^f' zaw-git-files
bindkey '^x^p' zaw-process
bindkey '^x^b' zaw-git-branches

#------ notify ------#
source $HOME/.zsh/behind-window-notify/behind-window-notify.zsh (N-/)


#------ tools ------#
if [[ $(uname) == "Linux" ]]; then
    export PATH="$HOME/.linuxbrew/bin:$PATH" (N-/)
    export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH" (N-/)
    export LD_LIBRARY_PATH="$HOME/.linuxbrew/lib:$LD_LIBRARY_PATH" (N-/)
fi

# grpe
dgrep(){
    if [ $# -eq 1 ]; then
        grep --color=auto -Hnr $1
    elif [ $# -eq 2 ]; then
        grep --color=auto -Hn $1 -- **/*.$2
    elif [ $# -gt 2 ]; then
        x=$1
        shift
        y=`echo $* | sed -e 's/ \+/|/g'`
        zsh -c "grep --color=auto -Hn $x -- **/*.($y)"
    fi
}
edgrep(){
    if [ $# -eq 1 ]; then
        grep --color=auto -EHnr $1
    elif [ $# -eq 2 ]; then
        grep --color=auto -EHn $1 -- **/*.$2
    elif [ $# -gt 2 ]; then
        x=$1
        shift
        y=`echo $* | sed -e 's/ \+/|/g'`
        zsh -c "grep -E --color=auto -Hn $x -- **/*.($y)"
    fi
}
pdgrep(){
    if [ $# -eq 1 ]; then
        grep --color=auto -PHnr $1
    elif [ $# -eq 2 ]; then
        grep --color=auto -PHn $1 -- **/*.$2
    elif [ $# -gt 2 ]; then
        x=$1
        shift
        y=`echo $* | sed -e 's/ \+/|/g'`
        zsh -c "grep -P --color=auto -Hn $x -- **/*.($y)"
    fi
}

run(){
    ./$1/Contents/MacOS/`basename $1 .app`
}

# make
mmake(){
    if [ $? -eq 0 ]; then
        if [ $# -eq 0 ]; then
            x=`egrep -c "^processor\s:\s[0-9]+$" /proc/cpuinfo`
            make -j $x
        elif [ $# -eq 1 ]; then
            make $1
        fi
    fi
}

remake(){
    make clean
    if [ $? -eq 0 ]; then
        if [ $# -eq 0 ]; then
            x=`egrep -c "^processor\s:\s[0-9]+$" /proc/cpuinfo`
            make -j $x
        elif [ $# -eq 1 ]; then
            make $1
        fi
    fi
}

# valgrind
alias dvalgrind="valgrind -v --error-limit=no --leak-check=full --leak-resolution=high --show-reachable=yes 2>&1"
alias dcvalgrind="valgrind -v --error-limit=no --leak-check=full --leak-resolution=high --show-reachable=yes --trace-children=yes 2>&1"

# vim
alias vi="vim"
alias vir="vim -R"
alias vin="vim -u NONE --noplugin"
alias agit="vim -c Agit"

# less
alias vless="/usr/local/share/vim/vim74/macros/less.sh"

# エイリアスいろいろ
alias du="du -h"
alias df="df -h"
alias su="su -l"
alias lv="lv -c"
alias grep="grep --color=auto"
alias rsync="rsync --progress"
alias rm="trash"
alias pc="percol"

alias g="git"
alias gitlog="git log --oneline --graph --decorate"
alias gitco="git checkout"
alias gita="git add"
alias gitc="git commit"
alias gits="git status"
alias gitl='git log'
alias gitd="git diff"
alias gitdc="git diff --cached"
alias gitru="git remote update"
alias lg="git lg"
alias lga="git lga"

case "${OSTYPE}" in
  darwin*)
    alias ls="ls -FGh"
    alias ll="ls -lFGh"
    alias la="ls -aFGh"
    alias lla="ls -laFGh"
    ;;
  linux*)
    alias ls="ls --color -Fh"
    alias la="ls --color -aFh"
    alias ll="ls --color -lFh"
    alias lla="ls --color -laFh"
    alias open="xdg-open"
    alias pbcopy="xsel --clipboard --input"
    alias pbpaste="xsel --clipboard --output"
    alias today="date +'%Y.%m.%d'"
    ;;
esac

#------ Python ------#
alias pyhttpserver="python -m SimpleHTTPServer 8080"

#------ cheat cheet ------#
cheat-sheet () { zle -M "`cat $HOME/.zsh/cheatsheets/cheat-sheet.conf`" }
zle -N cheat-sheet
bindkey "^[^h" cheat-sheet

git-cheat () { zle -M "`cat $HOME/.zsh/cheatsheets/git-cheat.conf`" }
zle -N git-cheat
bindkey "^[^g" git-cheat

screen-cheat () { zle -M "`cat $HOME/.zsh/cheatsheets/screen-cheat.conf`" }
zle -N screen-cheat
bindkey "^[^s" screen-cheat

tmux-cheat () { zle -M "`cat $HOME/.zsh/cheatsheets/tmux-cheat.conf`" }
zle -N tmux-cheat
bindkey "^[^b" tmux-cheat

command-cheat () { zle -M "`cat $HOME/.zsh/cheatsheets/command-cheat.conf`" }
zle -N command-cheat
bindkey "^[^j" command-cheat

# zshrc local setting
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
