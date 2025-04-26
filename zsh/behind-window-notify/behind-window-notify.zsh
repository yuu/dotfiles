
autoload -Uz add-zsh-hook

function remenber-cmd() {
    export LASTCMD=$1
}

add-zsh-hook preexec remenber-cmd

# $ osascript -e 'id of app "WezTerm"'
local terminal_identity="com.github.wez.wezterm"

function on_wezterm() {
    [[ -n $WEZTERM_PANE ]]
}

function on_tmux() {
    [[ -n $TMUX ]]
}

function is_wezterm_focus() {
    current_pane=$(wezterm cli list --format json |jq ".[] | select(.is_active==true) |.pane_id" |xargs)
    if [[ -n ${current_pane[(re)$WEZTERM_PANE]} ]]; then
        return 0
    else
        return 1
    fi
}

function is_tmux_focus() {
    current_panes=(${(@f)"$(tmux list-panes -F'#{pane_id}')"})
    [[ -z ${(M)current_panes#$TMUX_PANE} ]]
}

function notify() {
    local title=$1
    local message=$2
    local option="-activate ${terminal_identity}"

    if [[ ${OSTYPE} == darwin* ]]; then
        terminal-notifier -title "${title}" -message "${message}" ${option}
    else
        notify-send -t 3000 -u low "${message}"
    fi
}

function _behind-window-notify() {
    if on_wezterm; then
        if ! is_wezterm_focus; then
            if [[ -n $LASTCMD ]]; then
                notify "$LASTCMD" "exit"
            fi
        fi
    fi
}

function _behind-window-notify-tmux() {
    if on_tmux; then
        current_panes=(${(@f)"$(tmux list-panes -F'#{pane_id}')"})
        if is_tmux_focus; then
            if [[ -n $LASTCMD ]]; then
                notify "$LASTCMD" "exit"
            fi
        fi
    fi
}

# add-zsh-hook precmd _behind-window-notify
