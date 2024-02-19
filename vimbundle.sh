#! /bin/bash


mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim/bundle
git clone https://github.com/altercation/vim-colors-solarized.git
git clone https://github.com/arcticicestudio/nord-vim
git clone https://github.com/dense-analysis/ale ~/.vim/bundle/ale
git clone https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-go

cd ~/.vim/colors
curl -LSso pencil.vim  https://raw.githubusercontent.com/preservim/vim-colors-pencil/master/colors/pencil.vim 
curl -LSso toast.vim https://raw.githubusercontent.com/jsit/toast.vim/master/colors/toast.vim

