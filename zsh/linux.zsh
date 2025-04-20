# ls
alias ls="ls --color -Fh"
alias la="ls --color -aFh"
alias ll="ls --color -lFh"
alias lla="ls --color -laFh"

# エイリアスいろいろ
alias open="xdg-open > /dev/null 2>&1"
alias pbcopy="xsel --clipboard --input"
alias pbpaste="xsel --clipboard --output"

# time
alias date="date +%Y-%m-%dT%H:%M:%S%z"
alias today="command date '+%Y-%m-%d'"
alias now="command date '+%H:%M:%S'"
