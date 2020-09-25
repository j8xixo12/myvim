syntax on
"set t_Co=256
"colorscheme monokai
set go+=a
set number    
set autoindent
set mouse=a
set nowrap
set cursorline
set tabstop=4
set shiftwidth=4
set incsearch
set history=100
set smartcase
set expandtab
set autoread
set encoding=utf-8
set path+=**
autocmd FileType Makefile setlocal noexpandtab
set clipboard=unnamedplus
set backspace=indent,eol,start

let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-d>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-d>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-d>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'
