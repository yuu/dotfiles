# ls
alias ls="ls -FGh"
alias ll="ls -lFGh"
alias la="ls -aFGh"
alias lla="ls -laFGh"

# time
alias date="date +%Y-%m-%dT%H:%M:%S%z"
alias today="command date '+%Y-%m-%d'"
alias now="command date '+%H:%M:%S'"

path=(/opt/homebrew/bin(N-/) /opt/homebrew/sbin(N-/) ${path})
fpath=(/opt/homebrew/share/zsh-completions(N-/) /opt/homebrew/share/zsh/site-functions(N-/) ${fpath})
