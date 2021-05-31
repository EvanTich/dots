" my vim :)

source ~/.config/nvim/vim-plug.vim

" copy + paste
vnoremap <C-c> "+y
map <C-p> "+P
vnoremap <C-c> "*y :let @+=@*<CR>

" general
set number "sets the line numbers
" set numberwidth=4
set tabstop=4 "one tab = 4 spaces
set expandtab "tab -> spaces

set scrolloff=5
set backspace=indent,eol,start "fix some backspace problems
set autoindent
set ttyfast "speed up scrolling
set ruler

set incsearch
set spell spelllang=en_us
set wildmenu
set cursorline
set mouse=a "allow the mouse cursor to work when needed
syntax on

" plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'nekonako/xresources-nvim'
Plug 'scrooloose/NERDTree'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

let g:airline_theme='jellybeans'

" colorschemes
colorscheme jellybeans
" colorscheme xresources
