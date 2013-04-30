set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
 Bundle 'gmarik/vundle'
 Bundle 'scrooloose/nerdtree'
 Bundle 'jistr/vim-nerdtree-tabs'
 Bundle 'tpope/vim-fugitive'
 Bundle 'tpope/vim-rails'
 Bundle 'tpope/vim-haml'
 Bundle 'tpope/vim-surround'
 Bundle 'pangloss/vim-javascript'
" Bundle 'Lokaltog/vim-powerline'

filetype plugin indent on "req

let g:Powerline_symbols = 'fancy'  "powerline fix for proper font disply
"nerdtree displays without file specification and to close vim if only nerdtree open
autocmd vimenter * if !argc() | NERDTree | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

syntax enable
set nu
set ts=2
set shiftwidth=2
set autoindent
set smarttab
set expandtab
set showmatch
set encoding=utf-8
set laststatus=2
set term=screen-256color

"disable arrow keys / ctrl + hjkl window swap
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>
"map <C-h> <C-w>h
"map <C-j> <C-w>j
"map <C-k> <C-w>k
"map <C-l> <C-w>l
map ;; <Esc>:

if has('gui_running')
  set guifont=Inconsolata:h13    " set fonts for gui vim
  set transparency=5             " set transparent window
  set guioptions=egmrt           " hide the gui menubar
endif
