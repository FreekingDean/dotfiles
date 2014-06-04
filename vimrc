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
 Bundle 'kchmck/vim-coffee-script'
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
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-K> <C-W>k<C-W>_
map <C-K> <C-W>j<C-W>_

"Map ;; to <Esc>:'
imap ;; <Esc>:
map ;; <Esc>:

if has('gui_running')
  set guifont=Inconsolata:h13    " set fonts for gui vim
  set transparency=5             " set transparent window
  set guioptions=egmrt           " hide the gui menubar
endif

"Highlight trailing whitespace in red
:highlight ExtraWhitespace ctermbg=red guibg=red
:au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
:au InsertLeave * match ExtraWhitespace /\s\+$/
:match ExtraWhitespace /\s\+$/           " Show trailing whitespace
:match ExtraWhitespace /\s\+$\| \+\ze\t/ " Show trailing whitespace and spaces before a tab
:match ExtraWhitespace /[^\t]\zs\t\+/    " Show tabs that are not at the start of a line

"Auto Rspec on <,+t>
let mapleader=","
map <leader>t :w\|!rspec --drb --color %<cr>

au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino
au BufRead,BufNewFile *.go set filetype=go
set rtp+=/home/bananaboy/.local/lib/python2.7/site-packages/powerline/bindings/vim
