
autoload -Uz add-zsh-hook

function remenber-cmd(){
    export LASTCMD=$1
}

add-zsh-hook preexec remenber-cmd

# local terminal_identity="com.apple.Terminal"
local terminal_identity="com.googlecode.iterm2"

function behind-window-notify() {
  if [[ -n $TMUX ]] then
    current_panes=(${(@f)"$(tmux list-panes -F'#{pane_id}')"})
    if [[ -z ${(M)current_panes#$TMUX_PANE} ]] then

      if [[ ${OSTYPE} == darwin* ]] then
        ret=$?
        terminal-notifier -title "$LASTCMD" -message "$ret" -activate $terminal_identity
      else
        notify-send -t 3000 -u low "コマンド終了: " "$LASTCMD"
      fi

    fi
  fi
}

add-zsh-hook precmd behind-window-notify
