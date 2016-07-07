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

" KEYMAP
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
nnoremap <silent> [t :tabprevious<CR>
nnoremap <silent> ]t :tabnext<CR>
nnoremap <silent> [T :tabfirst<CR>
nnoremap <silent> ]T :tablast<CR>

" Edit vimrc
nnoremap ,v :edit $MYVIMRC<CR>
nnoremap ,V :edit ~/.config/vim/vimrc.local<CR>

" Ctrl + j, k, h, l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nnoremap <C-Down>  <C-w>j
nnoremap <C-Up>    <C-w>k
nnoremap <C-Left>  <C-w>h
nnoremap <C-Right> <C-w>l

" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q

" indent
vnoremap < <gv
vnoremap > >gv

" ESC Bind
imap <C-j> <Esc>
" SAVE
nnoremap <Space>w  :<C-u>w<CR>
" CLOSE
nnoremap <Space>z  :<C-u>q<CR>
nnoremap <Space>Z  :<C-u>q!<CR>

" OPEN/CLOSE QUICKFIX WINDOW SETTINGS
nnoremap <silent> <Space>q :<C-U>QFix<CR>

" macro
noremap q mq

" ------------------------------------------------------------------------------
" highway
" http://tkengo.github.io/blog/2015/10/19/release-highway/
"
nnoremap <Space>ug  :<C-u>Unite grep: -buffer-name=search-buffer<CR>

" unite grepにhw(highway)を使う
if executable('hw')
    let g:unite_source_grep_command = 'hw'
    let g:unite_source_grep_default_opts = '--no-group --no-color'
    let g:unite_source_grep_recursive_opt = ''
endif
