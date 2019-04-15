" Install Plug 
if empty(glob('~/.local/share/nvim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.local/share/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes
Plug 'ayu-theme/ayu-vim'

" Initialize plugin system
call plug#end()

set termguicolors     " enable true colors support
let ayucolor="dark"   " for dark version of theme
colorscheme ayu
