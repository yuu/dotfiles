set number
set laststatus=2
set showtabline=2
set scrolloff=5

" gvim hide scrollber
if has('gui_running')
    set guioptions-=r
    set guioptions-=L
    set guicursor=a:blinkon0
    set guifont=Source\ Han\ Code\ JP\ 9
endif

" Use English interface.
" if IsWindows()
"   " For Windows.
"   language message en
" else
"   " For Linux.
"   language message C
" endif

if has('syntax')
  set background=dark
  colorscheme hybrid
  hi Normal ctermbg=none

  " Line number color
  hi LineNr ctermfg=7
  " Current line number color
  hi CursorLineNr ctermbg=235 ctermfg=3
  " Row Color
  hi CursorLine ctermbg=235 guibg=Grey40

  hi Search ctermfg=250 ctermbg=26

  "スペルチェックを下線にする
  hi clear SpellBad
  hi SpellBad cterm=underline
  hi clear SpellCap
  hi SpellCap cterm=underline
  hi clear SpellRare
  hi SpellRare cterm=underline
  hi clear SpellLocal
  hi SpellLocal cterm=underline

  function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=darkgrey ctermbg=238 gui=underline guifg=darkgrey
  endfunction

  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /$B!!(B/
  augroup END
  call ZenkakuSpace()
endif
