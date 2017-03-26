set mouse =""

set undofile

" VIM Disable Automatic Newline At End Of File
set binary

set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8

" set ignorecase smartcase
set nowrapscan "検索をファイルの先頭へループしない
set incsearch
set hlsearch
if has('unix')
    set clipboard+=unnamedplus
endif

" TAB
set expandtab
set tabstop=8
set shiftwidth=4
set softtabstop=4
set smarttab

" See tab/space
set list
set listchars=tab:\|\ ,trail:~

" set paste
nnoremap <silent> ,p :<C-u>set paste!<CR>
      \:<C-u>echo("Toggle PasteMode => " . (&paste == 0 ? "Off" : "On"))<CR>

nnoremap <silent> ,P :<C-u>set list!<CR>
      \:<C-u>set number!<CR>
      \:<C-u>set foldcolumn=0<CR>
      \:<C-u>GitGutterToggle<CR>
      \:<C-u>echo("Toggle CopyMode => " . (&list == 0 ? "On" : "Off"))<CR>

nnoremap <silent> ,cd :<C-u>lcd %:h<CR>

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
nnoremap Q q
nnoremap q <Nop>

" 曖昧な文字列幅を全角
set ambiwidth=double

set cmdheight=2
set completeopt=menuone
let g:echodoc_enable_at_startup = 1

function! s:cpp_marker()
    set foldmethod=marker
    set foldmarker=R\"\(,\)\"\;
endfunction

augroup FoldMethod
    autocmd!
    autocmd FileType cpp call s:cpp_marker()
augroup END

augroup LastCursolPos
    autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup END

set path=.,include,../include,/usr/include,/usr/local/include

augroup ChangeFileTypeIndent
    autocmd!
    autocmd FileType markdown setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END
