set hidden
let g:LanguageClient_serverCommands = {
    \ 'python': ['/Users/laijunxu/.pyenv/shims/pyls'],
    \ 'c': ['clangd'],
    \ 'cpp': ['clangd'],
    \ }

nmap <F5> <Plug>(lcn-menu)
nmap <silent>K <Plug>(lcn-hover)
nmap <silent>gd <Plug>(lcn-definition)
nmap <silent>gr <Plug>(lcn-references)
nmap <silent>gI <Plug>(lcn-implementation)
nmap <silent>gs <Plug>(lcn-symbols)
