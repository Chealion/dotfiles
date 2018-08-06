
execute pathogen#infect()
filetype plugin indent on

syntax enable
set background=light
colorscheme solarized

set noswapfile
set nocompatible
set nobackup
set nowritebackup
set ruler
set incsearch
set hlsearch
set mouse=a

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set relativenumber
set modeline
set tw=78

set number
set numberwidth=4

set wrap
set formatoptions=qrn1
set colorcolumn=85

set backspace=indent,eol,start

autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.txt setlocal spell
autocmd FileType gitcommit setlocal spell
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

inoremap jj <ESC>

