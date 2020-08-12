" Vundle stuff
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'arcticicestudio/nord-vim'
Plugin 'fatih/vim-go'
Plugin 'preservim/nerdtree'
call vundle#end()
filetype plugin indent on
" End Vundle Stuff
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd vimenter * NERDTree

set t_Co=256
syntax on
set termguicolors
set number
let g:dracula_italic = 0
color dracula
highlight Normal ctermbg=None
