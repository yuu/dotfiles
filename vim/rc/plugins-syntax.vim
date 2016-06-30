" ------------------------------------------------------------------------------
" syntastic
"
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" なぜかQuickfix listのエラーがでるので必ず0にする
let g:syntastic_auto_loc_list = 0

let g:syntastic_enable_signs   = 1
let g:syntastic_error_symbol   = '✗'
let g:syntastic_warning_symbol = '⚠'

let g:syntastic_echo_current_error  = 1
let g:syntastic_enable_highlighting = 0

let g:syntastic_c_config_file   = '~/.clang_complete'
let g:syntastic_cpp_config_file = '~/.clang_complete'
let g:syntastic_cpp_compiler_options = '-std=c++14 -Wall -Weffc++'
let g:syntastic_c_compiler = 'clang++'

" cpplint
let g:syntastic_cpp_cpplint_thres = 5
let g:syntastic_cpp_cpplint_args = '--verbose=3'

nnoremap <silent> <Space>s :<C-u>SyntasticCheck cpplint<CR>

" ------------------------------------------------------------------------------
" 'vim-clang'
"
let g:clang_c_options = '-std=gnu11'
let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'
let g:clang_diagsopt = ''

" ------------------------------------------------------------------------------
" 'vim-json'
"
let g:vim_json_syntax_conceal = 0

" ------------------------------------------------------------------------------
" 'vim-markdown'
"
let g:vim_markdown_folding_disabled = 1

"------------------------------------------------------------------------------
" vim-cpp-enhanced-highlight
"
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1

" ------------------------------------------------------------------------------
" 'vim-go'
"
let g:go_highlight_functions = 1
let g:go_highlight_methods   = 1
let g:go_highlight_structs   = 1

" ------------------------------------------------------------------------------
" 'opengl'
"
autocmd BufRead *.c,*.h,*.cpp,*.hpp call MyOpenGLCheck()
function! MyOpenGLCheck()
  if search('^#include <gl.*\.h>','n') > 0 ||
  \  search('^#include <GL.*/gl.*\.h>', 'n') > 0 ||
  \  search('^#include <EGL/egl.h>', 'n') > 0
    NeoBundleSource opengl.vim
  endif
endfunction

" ------------------------------------------------------------------------------
" 'jedi-vim'
"
autocmd MyVimrc FileType python
\   let &l:path = system('python -', 'import sys;sys.stdout.write(",".join(sys.path))')
