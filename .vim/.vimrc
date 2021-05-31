" my vim :)

" copy + paste
vnoremap <C-c> "+y
map <C-p> "+P
vnoremap <C-c> "*y :let @+=@*<CR>

" general
syntax on                       " enable syntax highlighting
set number                      " sets the line numbers
set ruler                       " show cursor position
set numberwidth=4               " number of columns (minus one) taken up by the line number
" set tabstop=4                   " one tab = 4 spaces
set softtabstop=4               " tabs are always tabstop positions
set shiftwidth=4                " number of spaces for auto-indent
set expandtab                   " tab -> spaces
set smarttab                    " vim will tab smartly
set smartindent                 " smart indenting
set autoindent                  " auto indenting
set nowrap                      " long lines on one line
set scrolloff=10                " number of lines above and below cursor to see
set backspace=indent,eol,start  " fix some backspace problems
set splitbelow                  " horizontal splits will be below
set splitright                  " vertical splits will be to the right
set ttyfast                     " speed up scrolling..?
set incsearch                   " search as you type
set spell spelllang=en_us       " spelling
set wildmenu                    " better command-line completion
set cursorline                  " show horizontal line where the cursor is
set showtabline=1               " show tabs when there are 2 or more
set background=dark             " the background is dark (not exactly needed)
set mouse=a                     " allow the mouse cursor to work when needed
set clipboard=unnamedplus       " copy/paste between vim and system
" set autoread                    " auto-read the file if it is changed outside of vim
set hidden                      " apparently useful

set t_Co=256                    " fix colorscheme
set laststatus=2                " fix vim-airline

" future reference if needed
" if has('nvim')
" endif

" colorschemes
let g:airline_theme='jellybeans'
" colorscheme jellybeans
" colorscheme xresources

" plugins
call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'nekonako/xresources-nvim'
Plug 'scrooloose/NERDTree'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()
