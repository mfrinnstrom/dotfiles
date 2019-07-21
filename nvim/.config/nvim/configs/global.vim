" Configure theme
let base16colorspace=256 " Access colors present in 256 colorspace
colorscheme nord " Use the nord color theme

" Reload vimrc when it's saved
augroup reload_vimrc
    autocmd!
    autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
augroup END

set clipboard+=unnamedplus      " Use system clipboard, works with Crtl-C and Ctrl-V	
set signcolumn=yes              " Always show sign column for changes
set cursorline                  " Find the current line quickly.
set number                      " Show line numbers
set expandtab                   " Use spaces instead of tabs.
set softtabstop=4               " Tab key indents by 4 spaces.
