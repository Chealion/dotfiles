syntax enable
set background=dark
colorscheme solarized

execute pathogen#infect()
filetype plugin indent on

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

set number
set numberwidth=4

set wrap
set formatoptions=qrn1
set colorcolumn=85

set backspace=indent,eol,start

autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.txt setlocal spell
autocmd FileType gitcommit setlocal spell

inoremap jj <ESC>

