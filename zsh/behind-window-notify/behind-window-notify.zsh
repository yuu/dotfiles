
autoload -Uz add-zsh-hook

function remenber-cmd(){
    export LASTCMD=$1
}

add-zsh-hook preexec remenber-cmd

local terminal_identity="com.apple.Terminal"
if [[ ${OSTYPE} == darwin* ]] then
  if [[ "${TERM_PROGRAM}" == "iTerm.app" ]] then
    terminal_identity="com.googlecode.iterm2"
  fi
fi

function behind-window-notify() {
  if [[ -n $TMUX ]] then
    current_panes=(${(@f)"$(tmux list-panes -F'#{pane_id}')"})
    if [[ -z ${(M)current_panes#$TMUX_PANE} ]] then

      if [[ ${OSTYPE} == darwin* ]] then
        ret=$?
        /usr/local/bin/terminal-notifier -title "$LASTCMD" -message "$ret" -activate $terminal_identity
      else
        notify-send -t 3000 -u low "コマンド終了: " "$LASTCMD"
      fi

    fi
  fi
}

add-zsh-hook precmd behind-window-notify
