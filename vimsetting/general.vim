syntax on
set t_Co=256
set go+=a
set number    
set autoindent
set mouse=a
set nowrap
set cursorline
set tabstop=4
set shiftwidth=4
set hlsearch
set history=100
set smartcase
set expandtab
set autoread
set encoding=utf-8
set path+=**
autocmd FileType Makefile setlocal noexpandtab
set backspace=indent,eol,start
set noswapfile

nmap <silent> <leader><ESC> :let @/=""<CR>
