set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-surround'
Plugin 'fatih/vim-go'
Plugin 'thoughtbot/vim-rspec'
Plugin 'keith/rspec.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'kchmck/vim-coffee-script'
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'slim-template/vim-slim.git'
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'valloric/youcompleteme'
Plugin 'mileszs/ack.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'elixir-lang/vim-elixir'
Plugin 'ryanoasis/vim-devicons'

call vundle#end()            " required
filetype plugin indent on    " required

let g:Powerline_symbols = 'fancy'  "powerline fix for proper font disply
"nerdtree starts always open
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" ctags optimization
"set autochdir
"set tags=tags;

set lazyredraw
set regexpengine=1
set ttyfast
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
set clipboard=unnamed
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
"map <C-d> gf
"map <C-e> :A<CR>
"map <C-c> :R<CR>
"set number
set relativenumber

"Map ;; to <Esc>:'
imap ;; <Esc>:
map ;; <Esc>:

if has('gui_running')
  set guifont=Inconsolata:h13    " set fonts for gui vim
  "set transparency=5             " set transparent window
  set guioptions=egmrt           " hide the gui menubar
endif

"Highlight trailing whitespace in red
:highlight ExtraWhitespace ctermbg=red guibg=red
:au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
:au InsertLeave * match ExtraWhitespace /\s\+$/
:match ExtraWhitespace /\s\+$/           " Show trailing whitespace
:match ExtraWhitespace /\s\+$\| \+\ze\t/ " Show trailing whitespace and spaces before a tab
:match ExtraWhitespace /[^\t]\zs\t\+/    " Show tabs that are not at the start of a line


"Add commands for sudo write
:command SudoWrite w !sudo sh -c "cat >'%'"

"Auto Rspec on <,+t>
let mapleader=","
" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>g :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
map <Leader>b :Tagbar<CR>
nmap <silent> <leader>c :Gstatus<cr>
nnoremap <leader>. :CtrlPTag<cr>

"Run go prgm on <,+g+r>
map<leader>gr :w\|!go run %<cr>

au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino
au BufRead,BufNewFile *.go set filetype=go
au BufRead,BufNewFile *.tl set filetype=turlang
set rtp+=/home/bananaboy/.local/lib/python2.7/site-packages/powerline/bindings/vim

let spring_exists = system('spring -v')

"Spring rspec
"let g:rspec_command = '!spring rspec {spec}'
let g:rspec_command = '!RAILS_ENV=test bundle exec rspec {spec} --color --profile'

if has("gui_running")
endif

nmap \ :Ack!
