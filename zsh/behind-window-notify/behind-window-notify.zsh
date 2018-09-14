
autoload -Uz add-zsh-hook

function remenber-cmd(){
    export LASTCMD=$1
}

add-zsh-hook preexec remenber-cmd

function behind-window-notify(){
  if [[ -n $TMUX ]] then
    current_panes=(${(@f)"$(tmux list-panes -F'#{pane_id}')"})

    if [[ -z ${(M)current_panes#$TMUX_PANE} ]] then
      if [[ ${OSTYPE} == darwin* ]] then
	ret=$?
        growlnotify -n $LASTCMD -m "$LASTCMD: ($ret)"
      else
        notify-send -t 3000 -u low "コマンド終了: " "$LASTCMD"
       fi
    fi
  fi
}

add-zsh-hook precmd behind-window-notify
