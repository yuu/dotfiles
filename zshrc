source $HOME/dotfiles/zshrc-common
source $HOME/dotfiles/zshrc-env
source $HOME/dotfiles/zshrc-plugin
source $HOME/dotfiles/zshrc-func
source $HOME/dotfiles/zshrc-cheatcheet
source $HOME/dotfiles/zshrc-alias.common

case "${OSTYPE}" in
  darwin*)
    source $HOME/dotfiles/zshrc-alias.mac
    ;;
  linux*)
    source $HOME/dotfiles/zshrc-alias.linux
    ;;
esac

# zshrc local setting
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
