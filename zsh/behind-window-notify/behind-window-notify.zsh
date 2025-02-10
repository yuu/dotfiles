
autoload -Uz add-zsh-hook

function remenber-cmd(){
    export LASTCMD=$1
}

add-zsh-hook preexec remenber-cmd

# $ osascript -e 'id of app "WezTerm"'
local terminal_identity="com.github.wez.wezterm"

function behind-window-notify() {
  if [[ ${OSTYPE} == darwin* ]] then
    ret=$?
    terminal-notifier -title "$LASTCMD" -message "$ret" -activate $terminal_identity
  else
    notify-send -t 3000 -u low "コマンド終了: " "$LASTCMD"
  fi
}

add-zsh-hook precmd behind-window-notify
