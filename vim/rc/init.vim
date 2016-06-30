let $CACHE = expand('~/.cache')

if !isdirectory(expand($CACHE))
    call mkdir(expand($CACHE), 'p')
endif

let s:neobundle_dir = expand('$CACHE/neobundle')

if has('vim_starting')
    " Set runtimepath.
    if IsWindows()
        let &runtimepath = join([
            \ expand('~/.vim'),
            \ expand('$VIM/runtime'),
            \ expand('~/.vim/after')], ',')
    endif

    " Load neobundle.
    if finddir('neobundle.vim', '.;') != ''
        execute 'set runtimepath^=' .
            \ fnamemodify(finddir('neobundle.vim', '.;'), ':p')
    elseif &runtimepath !~ '/neobundle.vim'
        if !isdirectory(s:neobundle_dir.'/neobundle.vim')
            execute printf('!git clone %s://github.com/Shougo/neobundle.vim.git',
                \ (exists('$http_proxy') ? 'https' : 'git'))
                \ s:neobundle_dir.'/neobundle.vim'
        endif

        execute 'set runtimepath^=' . s:neobundle_dir.'/neobundle.vim'
    endif
endif

let g:neobundle#default_options = {}

"---------------------------------------------------------------------------
" Disable default plugins
"
" Disable menu.vim
" Disable GetLatestVimPlugin.vim
" if !&verbose
"   let g:loaded_getscriptPlugin = 1
" endif

" let g:loaded_netrwPlugin = 1
" let g:loaded_matchparen = 1
" let g:loaded_2html_plugin = 1
" let g:loaded_vimballPlugin = 1

"------------------------------------------------------------------------------
" Search
"
" set ignorecase smartcase
set nowrapscan "検索をファイルの先頭へループしない
set incsearch
set hlsearch


"----
if has('gui_running')
    set t_Co=256
endif

" https://github.com/vim-jp/issues/issues/305
if (v:version > 704 || (v:version == 704 && has('patch314')))
  set shortmess=c
endif

set ttyfast
set lazyredraw
set list
set listchars=tab:\|\ ,trail:~
set display=uhex
" 曖昧な文字列幅を全角
set ambiwidth=double

" ファイル
set autoread
set hidden
set noswapfile

" cursor
" match pairs
set matchpairs& matchpairs+=<:>

" CLIP BOARD
if IsMac()
    set clipboard=unnamed,autoselect
else
    set clipboard=unnamedplus
end

" command mode
set wildmenu wildmode=longest:full,full

set noerrorbells
if IsMac()
    " set visualbell t_vb=
    set noerrorbells
    set novisualbell
    set t_vb=
end

let g:localvimrc_ask=0        " いちいち聞かずに勝手に読み込む
let g:localvimrc_persistent=2 " 一度聞いたファイルを記録しておき、次回からは自動で読み込む
let g:localvimrc_persistent=1 " 聞いたときに大文字のY/N/Aで答えた場合のみ上記の動作をする"

" disable backup
set nobackup
