" Enable debugging
let g:ycm_keep_logfiles = 1
let g:ycm_log_level = 'debug'
let g:ycm_enable_diagnostic_highlighting = 0
" If the base settings don't repro, paste your existing config for YCM only,
" here:
" let g:ycm_....

" Load YCM (only)
let &rtp .= ',' . expand( '<sfile>:p:h' )
filetype plugin indent on

map <silent> <F12> :YcmCompleter GoToDefinition<CR>
map <silent> <F8> :YcmCompleter GoToReferences<CR>

