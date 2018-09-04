" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" Theme
"Plug 'chriskempson/base16-vim'
Plug 'arcticicestudio/nord-vim'

" Bar
Plug 'itchyny/lightline.vim'
"Plug 'daviesjamie/vim-base16-lightline'

" Fuzzy finding
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" General plugins
Plug 'Shougo/denite.nvim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'ryanoasis/vim-devicons'
Plug 'unblevable/quick-scope'

" Initialize plugin system
call plug#end()

" Configure theme
let base16colorspace=256       	" Access colors present in 256 colorspace
colorscheme nord

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

set noshowmode               	" Don't show current mode in command-line.
set showcmd                	" Show already typed keys when more are expected.
set wildmenu                    " Visual autocomplete for command menu

set incsearch              	" Highlight while searching with / or ?.
set hlsearch               	" Keep matches highlighted.

set splitbelow             	" Open new windows below the current window.
set splitright             	" Open new windows right of the current window.

set cursorline             	" Find the current line quickly.
set nowrap                      " Don't wrap lines
set wrapscan               	" Searches wrap around end-of-file.

set updatetime=250              " Update more often, default is 4s
set signcolumn=yes              " Always show sign column for changes

" Reload vimrc when it's saved
augroup reload_vimrc
    autocmd!
    autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
augroup END

" =================================
" Configure general key bindings
" =================================
let mapleader = ',' " Configure leader

" Denite
nnoremap <C-p> :<C-u>Denite file_rec<CR> " open file
nnoremap <leader>s :<C-u>Denite buffer<CR> " switch buffer
nnoremap <leader>d :<C-u>DeniteBufferDir file_rec<CR> " open file in current dir
nnoremap <leader>8 :<C-u>DeniteCursorWord grep:. -mode=normal<CR> " search for the word the curser is on

" =================================
" Plugin settings
" =================================

" === lightline ===================
let g:lightline = {
\ 'colorscheme': 'nord',
\ }

" === deoplete ====================
let g:deoplete#enable_at_startup = 1        " Enable deoplete.nvim at startup

" === quick-scope =================
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" === denite ======================
" Use ag
call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

" Ag command on grep source
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Change mappings.
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')

" Change default prompt
call denite#custom#option('default', 'prompt', '>')
