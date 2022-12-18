" my vim :)
set encoding=utf-8
let mapleader=" "

" plugins
call plug#begin('~/.config/nvim/plugged')
" polyglot + coc
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'nekonako/xresources-nvim'

" indentation guides
Plug 'yggdroot/indentline'
let g:indentLine_char='▏'
let g:indentLine_fileTypeExclude=['markdown', 'vimwiki']

" code focus
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
let g:limelight_conceal_ctermfg='gray'
nnoremap <Leader>go :Goyo<CR>
augroup Goyo
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight! | hi Normal guibg=NONE ctermbg=NONE
augroup END

" nerd tree
Plug 'scrooloose/nerdtree'
nnoremap <Leader>nt :NERDTreeToggle<CR>

" nerd tree git integration
Plug 'xuyuanp/nerdtree-git-plugin'

" really cool/useful movement
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_smartcase=1

" comment manipulation
Plug 'preservim/nerdcommenter'
let g:NERDSpaceDelims=1
let g:NERDCompactSexyComs=1
let g:NERDAltDelims_java=1
let g:NERDTrimTrailingWhitespace=1
let g:NERDToggleCheckAllLines=1

" start screen when no file is opened
Plug 'mhinz/vim-startify'
" let g:startify_custom_header = [...]

" git diffs in the gutter
Plug 'airblade/vim-gitgutter'

" highlight any trailing whitespace
Plug 'bronson/vim-trailing-whitespace'

" automatically pair delimiters
" NOTE: fucks with remapping <CR> if enabled
"Plug 'jiangmiao/auto-pairs'
"let g:AutoPairsMapCR=0

" icons for nerdtree and others
Plug 'ryanoasis/vim-devicons'

" airline + themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts=1

" markdown table creator
Plug 'dhruvasagar/vim-table-mode'

" personal wiki and organization things
Plug 'vimwiki/vimwiki'
let g:vimwiki_list=[{'path': '~/Documents/VimWiki/vimwiki/',
    \ 'path_html': '~/Documents/VimWiki/vimwiki_html/',
    \ 'template_path': '~/Documents/VimWiki/vimwiki/templates/'}]

" help with commands
Plug 'liuchengxu/vim-which-key'
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>

" fix coc completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
augroup CoC
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

call plug#end()

" copy + paste
vnoremap <C-c> "+y
map <C-p> "+P
vnoremap <C-c> "*y :let @+=@*<CR>

" general
syntax on                       " enable syntax highlighting
filetype plugin on              " run filetype plugins
set number                      " sets the line numbers
" set relativenumber              " relative numbers :)
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
set nospell                     " get rid of spell checking
set ignorecase                  " ignore case when searching
set smartcase                   " do a case sensitive search automatically when there are uppercase letters

set t_Co=256                    " fix colorscheme
set laststatus=2                " fix vim-airline

set undodir=~/.local/share/nvim/undodir
set undofile

set viminfo=!,'100,<50,s10,h,n~/.local/share/nvim/viminfo

" cursorline settings
hi CursorLine cterm=bold gui=bold ctermbg=None ctermfg=None guibg=None guifg=None
hi CursorLineNr cterm=bold gui=bold

" future reference if needed
" if has('nvim')
" endif

" mappings to move between splits
nnoremap <Leader>wh :wincmd h<CR>
nnoremap <Leader>wl :wincmd l<CR>
nnoremap <Leader>wj :wincmd j<CR>
nnoremap <Leader>wk :wincmd k<CR>
nnoremap <Leader>w  :wincmd<space>

" mapping to get rid of highlights from searches
nnoremap <Leader>hl :let @/=""<CR>

" mapping to get rid of trailing whitespace
nnoremap <Leader>fw :FixWhitespace<CR>

" CoC mappings
nnoremap <Leader>ct     :CocCommand<space>terminal.Toggle<CR>
tnoremap <Leader>ct     <C-\><C-n>:CocCommand<space>terminal.Toggle<CR>
nnoremap <Leader>rcw    :CocCommand<space>document.renameCurrentWord<CR>
nnoremap <Leader>cso    :CocList<space>outline<CR>
nnoremap <Leader>y      :<C-u>CocList -A --normal yank<CR>
nnoremap <leader>col    :CocList<CR>

" vimwiki
augroup VimWiki
    autocmd FileType .wiki BufWritePost Vimwiki2HTML
augroup END

" colorschemes
" colorscheme jellybeans
" colorscheme xresources
let g:airline_theme='jellybeans'
