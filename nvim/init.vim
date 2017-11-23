scriptencoding utf-8

let s:conf_dir = expand('~/.config/nvim')
let s:dein_dir = expand('~/.cache/nvim')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif

source ~/.config/nvim/configuration.vim
set path=.,include,../include,/usr/include,/usr/local/include,**

" プラグインの追加・削除やtomlファイルの設定を変更した後は
" 適宜 call dein#update や call dein#clear_state を呼んでください。
execute 'set runtimepath^=' . s:dein_repo_dir
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    call dein#load_toml(s:conf_dir . '/dein.toml', {'lazy': 0})
    call dein#load_toml(s:conf_dir . '/git.toml', {'lazy': 0})
    call dein#load_toml(s:conf_dir . '/lang.toml', {'lazy': 0})

    call dein#end()
    call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif

if filereadable(expand('~/.config/nvim/local.vim'))
    source ~/.config/nvim/local.vim
endif

" find vimrc from current repository
augroup vimrc-local
    autocmd!
    autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
    let files = findfile('.vimrc.proj', escape(a:loc, ' ') . ';', -1)
    for i in reverse(filter(files, 'filereadable(v:val)'))
        source `=i`
    endfor
endfunction

" must be deoplete
filetype plugin indent on
