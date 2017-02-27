" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" Theme
Plug 'chriskempson/base16-vim'

" Bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Fuzzy finding
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" General plugins
Plug 'Shougo/denite.nvim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'

" Initialize plugin system
call plug#end()

" Configure theme
let base16colorspace=256       	" Access colors present in 256 colorspace
colorscheme base16-oceanicnext 	" Set the theme
let g:airline_theme='base16'

set nocompatible

filetype plugin indent on      	" Load plugins according to detected filetype.
syntax on                  	" Enable syntax highlighting.

set number                      " Show line numbers
set autoindent             	" Indent according to previous line.
set expandtab              	" Use spaces instead of tabs.
set softtabstop=4         	" Tab key indents by 4 spaces.
set shiftwidth=4         	" >> indents by 4 spaces.
set shiftround             	" >> indents to next multiple of 'shiftwidth'.

set backspace=indent,eol,start  " Make backspace work as you would expect.
set hidden                 	" Switch between buffers without having to save first.
set laststatus=2         	" Always show statusline.
set display=lastline	  	" Show as much as possible of the last line.

set showmode               	" Show current mode in command-line.
set showcmd                	" Show already typed keys when more are expected.
set wildmenu                    " Visual autocomplete for command menu

set incsearch              	" Highlight while searching with / or ?.
set hlsearch               	" Keep matches highlighted.

set splitbelow             	" Open new windows below the current window.
set splitright             	" Open new windows right of the current window.

set cursorline             	" Find the current line quickly.
set wrapscan               	" Searches wrap around end-of-file.

set updatetime=250              " Update more often, default is 4s

" Reload vimrc when it's saved
augroup reload_vimrc
    autocmd!
    autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
augroup END

" Configure general plugins
let g:deoplete#enable_at_startup = 1        " Enable deoplete.nvim at startup
let g:airline_powerline_fonts = 1           " Use PowerLine fonts in vim-airline
let g:gitgutter_sign_column_always = 1      " Always show sign column for changes

" Configure general key bindings
let mapleader = ','                         " Configure leader
