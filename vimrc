if !has('nvim')                " vim specific vs neovim below
  set nocompatible             " be iMproved

  " install Vim-plug if not installed
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

if has('nvim')
  set mouse-=a                 " not ready for mouse use yet

  if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

let s:darwin = has('mac')

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs', {'on': 'NERDTreeToggle'}

Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'

Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-surround'

"Plug 'scrooloose/syntastic'
Plug 'neomake/neomake'
Plug 'airblade/vim-gitgutter'
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'

Plug 'tpope/vim-rails', {'for': 'ruby'}
Plug 'tpope/vim-haml', {'for': 'haml'}
Plug 'janko-m/vim-test', {'for': 'ruby'}
Plug 'keith/rspec.vim', {'for': 'ruby'}
Plug 'kchmck/vim-coffee-script'
Plug 'hashivim/vim-terraform', {'for': ['tf', 'terraform']}

Plug 'emilyst/vim-xray'

Plug 'pangloss/vim-javascript', {'for': ['js', 'jsx', 'ruby']}
Plug 'mxw/vim-jsx', {'for': ['js', 'jsx']}

Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoUpdateBinaries' }

Plug 'elixir-lang/vim-elixir', {'for': 'elixer'}

"if s:darwin
  Plug 'fielding/vim-chunkwm-navigator'
  Plug 'junegunn/vim-xmark'
"endif

" https://github.com/junegunn/dotfiles/blob/master/vimrc
function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py --all
  endif
endfunction

"Plug 'Valloric/YouCompleteMe',          { 'do': function('BuildYCM') }
Plug 'OmniSharp/omnisharp-vim'

" note taking and writing
Plug 'rhysd/vim-grammarous',            { 'for': ['text', 'markdown'] }
Plug 'beloglazov/vim-online-thesaurus', { 'for': ['text', 'markdown'] }

call plug#end()

filetype plugin indent on    " required

let g:airline_powerline_fonts = 1

"nerdtree starts always open
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | en

" ctags optimization
"set autochdir
"set tags=tags;

set lazyredraw
set regexpengine=1
set ttyfast
syntax enable
set nohlsearch
set nu
set ts=2
set shiftwidth=2
set autoindent
set smarttab
set expandtab
set showmatch
set encoding=utf-8
set laststatus=2
"set term=screen-256color
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
" :command SudoWrite w !sudo sh -c "cat >'%'"

"Auto Rspec on <,+t>
let mapleader=","
" RSpec.vim mappings
map <Leader>t :TestFile<CR>
map <Leader>g :TestNearest<CR>
map <Leader>l :TestLast<CR>
map <Leader>a :TestSuite<CR>
map <Leader>b :Tagbar<CR>
nmap <silent> <leader>c :Gstatus<cr>
nnoremap <leader>. :CtrlPTag<cr>

"Run go prgm on <,+g+r>
map<leader>gr :w\|!go run %<cr>

"Run ruby prgm on <,+g+r>
map<leader>rr :w\|!ruby %<cr>

au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino
au BufRead,BufNewFile *.go set filetype=go
au BufRead,BufNewFile *.tl set filetype=turlang
"set rtp+=/home/bananaboy/.local/lib/python2.7/site-packages/powerline/bindings/vim

let spring_exists = system('spring -v')

"Spring rspec
"let g:rspec_command = '!spring rspec {spec}'
let g:rspec_command = '!RAILS_ENV=test bundle exec rspec {spec} --color --profile'

nmap \ :Ack!

"Vim-Tmux split nav
let g:chunkwm_navigator_no_mappings = 1

nnoremap <silent> <C-w>h :ChunkwmNavigateLeft<cr>
nnoremap <silent> <C-w>j :ChunkwmNavigateDown<cr>
nnoremap <silent> <C-w>k :ChunkwmNavigateUp<cr>
nnoremap <silent> <C-w>l :ChunkwmNavigateRight<cr>

nnoremap <C-w>r :source $HOME/.vimrc<cr>

nnoremap <C-w><C-w> :tabp<cr>
map <C-w>c :tabe <bar> :term<cr>
nnoremap <C-w>r :source $HOME/.vimrc<cr>
nnoremap <C-w>z <C-w><bar><C-w>_

" Set swapfiles to homedir
set directory=$HOME/.vim/swapfiles//

let g:syntastic_python_checkers = []
"let g:syntastic_ruby_checkers = ['rubocop', 'mri']
"let g:syntastic_go_checkers = ['golint']
"call neomake#configure#automake('nrwi', 500)
"let g:neomake_open_list = 2
"let g:ycm_auto_trigger = 1

"Let <Esc> return to normal mode in term
tnoremap <Esc> <C-\><C-n>
colorscheme delek
"Get the 2-space YAML as the default when hit carriage return after the colon
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
set omnifunc=syntaxcomplete#Complete
