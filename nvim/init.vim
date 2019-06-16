" Install Plug 
if empty(glob('~/.local/share/nvim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.local/share/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes
Plug 'airblade/vim-gitgutter'
Plug 'ayu-theme/ayu-vim'
Plug 'cespare/vim-toml'
Plug 'chr4/nginx.vim'
Plug 'ekalinin/Dockerfile.vim' 
Plug 'elzr/vim-json'
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-terraform'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'modille/groovy.vim'
Plug 'plasticboy/vim-markdown'
Plug 'stephpy/vim-yaml'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'

" Initialize plugin system
call plug#end()

" Setup colors
set termguicolors     " enable true colors support
let ayucolor="dark"   " for dark version of theme
colorscheme ayu

" ALE
" Only run what I specifically ask for
let g:ale_linters_explicit = 1

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'python': ['black'], 
\ }

let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1

" Statusline
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
" let g:airline_section_a = ''
let g:airline_section_b = '%{FugitiveHead()}'
let g:airline_section_c = '%m%r'
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = '%l:%c'

" GitGutter
if exists('&signcolumn')  
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif
" Markdown
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
"Prevent setting conceal
let g:vim_json_syntax_conceal = 0

" Terraform
" Prevent fmt on save since ale does it
let g:terraform_fmt_on_save=1

"""""
" Key bindings
"""""

" change the leader key from "\" to the space bar
let mapleader="\<SPACE>"

" Alternate ways to exit insert mode
inoremap <M-CR> <Esc>
inoremap jk <Esc>

" Quick way out of all buffers when using merge tool
nnoremap <leader>q :qa<CR>
" Shortcut to edit THIS configuration file: (e)dit (c)onfiguration
nnoremap <silent> <leader>ec :e $MYVIMRC<CR>
" Shortcut to source (reload) THIS configuration file after editing it: (s)ource (c)onfiguraiton
nnoremap <silent> <leader>sc :source $MYVIMRC<CR>
" Move between buffers
nnoremap <silent> <leader><leader> :bprevious<CR>
" Close current buffer
nnoremap <silent> <leader>w :bd<cr>
" Searching
nnoremap <silent> <leader>c :nohlsearch<CR>
nnoremap <leader>s :%s//g<Left><Left>
" Copy/paste to clipboard
nnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
" Disable arrow keys in normal mode
nnoremap <Left> <nop>
nnoremap <Right> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>
" Easier movement between splits
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
" File selection
nnoremap <leader>e :Explore<cr>

""""
" General settings
" hat tips to tpope/vim-sensible
" http://nerditya.com/code/guide-to-neovim/ 
"""""
set encoding=utf-8

set nonumber
set incsearch
set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab
set showmatch

set nrformats-=octal

set laststatus=2
set ruler
set wildmenu

" searching
set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters
set gdefault            " Use 'g' flag by default with :s/foo/bar/

" Scrolling display
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline


if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Joining
set formatoptions+=j " Delete comment character when joining commented lines
set formatoptions+=o " Continue comment marker in new lines 

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

set autoread

set history=1000
set tabpagemax=50

if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif
" Prevent creation of .netrwhist files
let g:netrw_dirhistmax = 0
let g:netrw_liststyle = 3
let g:netrw_banner = 0

" Set default indent to 2 spaces
set tabstop=4
set shiftwidth=4
set expandtab
