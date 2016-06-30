" ------------------------------------------------------------------------------
" unite-gtags
"
" keymap
" lists references of a word. (It executes global -qrs -e <pattern> in internal.)
nnoremap <silent> <Space>gr :<C-u>Unite gtags/ref<CR>
" lists definitions of a word. (It executes global -qd -e <pattern> in internal.)
nnoremap <silent> <Space>gd :<C-u>Unite gtags/def<CR>
" lists grep result of a word. (It executes global -qg -e <pattern> in internal.)
nnoremap <silent> <Space>gg :<C-u>Unite gtags/grep<CR>

" sample
" \   '/tmp/sample/': {
" \     'gtags_libpath':
" \       [ '/usr/include/'
" \       , '/home/foo/my/include/'
" \       ]
" \   }

if IsMac()
    let g:unite_source_gtags_project_config = {
    \   '_': {
    \     'gtags_libpath':
    \       [ '/usr/local/include/' ]
    \   }
    \ }
end

if IsMac() && IsWindows()
    let g:unite_source_gtags_project_config = {
    \   '_': {
    \     'gtags_libpath':
    \       [ '/usr/include/',
    \         '/usr/include/'
            ]
    \   }
    \ }
end

" ------------------------------------------------------------------------------
" vim-quickrun
"
let g:quickrun_no_default_key_mappings = 1
"QuickRunのキーマップ
vnoremap <silent><Space>pr :QuickRun<CR>

let g:quickrun_config = {
\   '_' : {
\       'runner' : 'vimproc',
\       'runner/vimproc/updatetime' : 40,
\   },
\   'qml/qmlscene' : {
\       'command' : 'qmlscene',
\       'exec' : '%c %s:p'
\   },
\   'cpp' : {
\       'command': 'g++',
\       'cmdopt': '-std=c++11'
\   }
\}

let g:quickrun_config['qml'] = g:quickrun_config['qml/qmlscene']

" ------------------------------------------------------------------------------
" auto-pairs
"
let g:AutoPairsShortcutToggle = '' " disable
let g:AutoPairsShortcutJump = '' " disable
let g:AutoPairsShortcutBackInsert = '' " disable
let g:AutoPairsShortcutFastWrap = '<C-e>'

" ------------------------------------------------------------------------------
" vim-expand-region
"
vmap <C-v> <Plug>(expand_region_expand)
vmap v     <Plug>(expand_region_shrink)

" ------------------------------------------------------------------------------
" clever-f
"
let g:clever_f_across_no_line=1

" ------------------------------------------------------------------------------
" caw
"
" デフォルトマッピングを OFF
let g:caw_no_default_keymappings = 1
" キーマッピング
nmap <silent> ,/ <Plug>(caw:i:toggle)
vmap <silent> ,/ <Plug>(caw:i:toggle)

" ------------------------------------------------------------------------------
" vim-hier
"
let g:hier_enabled = 1

" ------------------------------------------------------------------------------
" 'VimFiler'
"
"vimデフォルトのエクスプローラをvimfilerで置き換える
let g:vimfiler_as_default_explorer = 1
"Auto change of current directory
let g:vimfiler_enable_auto_cd = 1

"デフォルトのキーマッピングを変更
if !has('gui_running')
    nnoremap <silent> <Space>ff :VimFilerBufferDir -simple<CR>
else
    nnoremap <silent> <Space>ff :VimFiler<CR>
end

augroup vim-filer
    autocmd FileType vimfiler call s:vimfiler_my_settings()
augroup END
function! s:vimfiler_my_settings()
    nmap <buffer> q <Plug>(vimfiler_hide)
    nmap <buffer> Q <Plug>(vimfiler_exit)
    nmap <buffer> <C-j> <C-w>j
    nmap <buffer> <C-k> <C-w>k
    nmap <buffer> <C-h> <C-w>h
    nmap <buffer> <C-l> <C-w>l
endfunction
