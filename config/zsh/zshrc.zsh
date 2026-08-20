# profiling / time zsh -icx exit
#zmodload zsh/zprof

local cpath=$HOME/.config/zsh

source $cpath/env.zsh
source $cpath/general.zsh
source $cpath/plugin.zsh
source $cpath/func.zsh
source $cpath/common.zsh

case "${OSTYPE}" in
  darwin*)
    source $cpath/mac.zsh
    ;;
  linux*)
    source $cpath/linux.zsh
    ;;
esac

# zshrc local setting
[ -f $cpath/local.zsh ] && source $cpath/local.zsh

autoload -U compinit
compinit

# workaround: diff args2 file name completion not working
compdef '_diff_options diff "*:file:_files"' diff

# profiling
# if type zprof > /dev/null 2>&1; then
#     zprof |less
# fi
