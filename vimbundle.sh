#! /bin/bash


mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim/bundle
git clone git://github.com/altercation/vim-colors-solarized.git
git clone https://github.com/arcticicestudio/nord-vim
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git
git clone https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-go

