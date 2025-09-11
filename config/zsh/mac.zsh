# ls
alias ls="ls -FGh"
alias ll="ls -lFGh"
alias la="ls -aFGh"
alias lla="ls -laFGh"

# time
alias date="date +%Y-%m-%dT%H:%M:%S%z"
alias today="command date '+%Y-%m-%d'"
alias now="command date '+%H:%M:%S'"

alias z=yazi

path=(/opt/homebrew/bin(N-/) /opt/homebrew/sbin(N-/) ${path})
fpath=(/opt/homebrew/share/zsh-completions(N-/) /opt/homebrew/share/zsh/site-functions(N-/) ${fpath})

source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
source <(zoxide init zsh)
source <(fzf --zsh)

source <(navi widget zsh)
bindkey -r '^G'
bindkey "^[j" _navi_widget

source <(mise activate zsh)
. "$HOME/.cargo/env"
