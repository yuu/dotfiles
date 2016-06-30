" TAB
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab

" INDENT
set autoindent
set smartindent

if exists('+breakindent')
  set breakindent
endif

" BACKSPACE
set backspace=indent,eol,start

if has('persistent_undo')
  set undofile
  set undodir=./.vimundo,~/.cache/undo
endif

set foldenable
set foldcolumn=1
set foldtext=Mopp_fold()
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo

function! Mopp_fold()
    let line = ' ' . substitute(getline(v:foldstart), '^\s*', '', '')
    for i in range(&shiftwidth * v:foldlevel - 2)
        let line = '-' . line
    endfor
    let line = '+' . line

    let tail = printf('[ %2d Lines Lv%02d ] --- ', (v:foldend - v:foldstart + 1), v:foldlevel)

    let space_size = (winwidth(0) - &foldcolumn - strdisplaywidth(line . tail) - 1) - ((&number) ? max([&numberwidth, len(line('$'))]) : 0)

    return printf('%s%' . space_size . 'S%s', line, '', tail)
endfunction

" ------------------------------------------------------------------------------
" file type 毎設定
" -- C/C++
" 標準ライブラリへのパスを設定
" http://d.hatena.ne.jp/osyo-manga/20131219/1387465034
"
let $CPP_STDLIB = "/usr/include/c++"
augroup vimrc-set_filetype_cpp_stdlib
    autocmd!
    " $CPP_STDLIB よりも下の階層のファイルが開かれて
    " filetype が設定されていない場合に filetype=cpp を設定する
    autocmd BufReadPost $CPP_STDLIB/* if empty(&filetype) | set filetype=cpp | endif
augroup END

" ------------------------------------------------------------------------------
" 名前空間の入力を簡単にする
" http://rhysd.hatenablog.com/entry/2013/12/10/233201#namespace
"
augroup cpp-namespace
    autocmd!
    autocmd FileType cpp inoremap <buffer><expr>; <SID>expand_namespace()
augroup END
function! s:expand_namespace()
    let s = getline('.')[0:col('.')-1]
    if s =~# '\<b;$'
        return "\<BS>oost::"
    elseif s =~# '\<s;$'
        return "\<BS>td::"
    elseif s =~# '\<d;$'
        return "\<BS>etail::"
    else
        return ';'
    endif
endfunction
