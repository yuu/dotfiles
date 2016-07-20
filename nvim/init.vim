scriptencoding utf-8

if &compatible
  set nocompatible
endif

let s:conf_dir = expand('~/.config/nvim')
let s:dein_dir = expand('~/.cache/nvim')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif

" プラグインの追加・削除やtomlファイルの設定を変更した後は
" 適宜 call dein#update や call dein#clear_state を呼んでください。
execute 'set runtimepath^=' . s:dein_repo_dir
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    call dein#load_toml(s:conf_dir . '/dein.toml', {'lazy': 0})
"    call dein#load_toml(s:conf_dir . '/dein_lazy.toml', {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif

set mouse =""

set number
" set ignorecase smartcase
set nowrapscan "検索をファイルの先頭へループしない
set incsearch
set hlsearch

" TAB
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab

" See tab/space
set listchars=tab:\|\ ,trail:~

" set paste
nnoremap <silent> ,p :<C-u>set paste!<CR>
      \:<C-u>echo("Toggle PasteMode => " . (&paste == 0 ? "Off" : "On"))<CR>

nnoremap <silent> ,P :<C-u>set list!<CR>
      \:<C-u>set number!<CR>
      \:<C-u>set foldcolumn=0<CR>
      \:<C-u>GitGutterToggle<CR>
      \:<C-u>echo("Toggle CopyMode => " . (&list == 0 ? "On" : "Off"))<CR>

" clear search highlight
nnoremap ,, :<C-u>nohlsearch<CR>

" Ctrl + j, k, h, l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" neovim bug?
nnoremap <BS> <C-W>h

inoremap <C-a> <HOME>
inoremap <C-e> <END>

nnoremap Q <Nop>
nnoremap ZQ <Nop>
nnoremap ZZ <Nop>

" indent
vnoremap < <gv
vnoremap > >gv

" ESC Bind
imap <C-j> <Esc>
nnoremap <Space>w  :<C-u>w<CR>
nnoremap <Space>z  :<C-u>q<CR>
nnoremap <Space>Z  :<C-u>q!<CR>

" macro
noremap q mq

" 曖昧な文字列幅を全角
" set ambiwidth=double

if filereadable(expand('~/.config/nvim/init.local'))
    source ~/.config/vim/vimrc.local
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

function! s:cpp_marker()
    set foldmethod=marker
    set foldmarker=R\"\(,\)\"\;
endfunction

augroup FoldMethod
    autocmd!
    autocmd FileType cpp call s:cpp_marker()
augroup END

filetype plugin indent on
