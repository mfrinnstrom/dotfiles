if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" Color scheme
Plug 'arcticicestudio/nord-vim'

" Sensible defaults
Plug 'tpope/vim-sensible'

" editorconfig
Plug 'editorconfig/editorconfig-vim'

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" More targets to operate on
Plug 'wellle/targets.vim'

" More clever f and F
Plug 'rhysd/clever-f.vim'

" Better definition of a work, supports camelCase and other
Plug 'chaoren/vim-wordmotion'

" Show VCS changes in sign column
Plug 'mhinz/vim-signify'

" Persistent session manager
Plug 'thaerkh/vim-workspace'

" Git workflow
Plug 'jreybert/vimagit'

" Initialize plugin system
call plug#end()

" Set the full color compatibility for vim and terminal
syntax enable
