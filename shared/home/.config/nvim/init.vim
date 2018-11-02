"Specify plugin directory
call plug#begin('~/.local/share/nvim/plugged')

"Load plugins
Plug 'bling/vim-airline'
Plug 'bronson/vim-trailing-whitespace'
Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'editorconfig/editorconfig-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'myusuf3/numbers.vim'
Plug 'thiagoalessio/rainbow_levels.vim'
Plug 'morhetz/gruvbox'

"Initialise plugin system
call plug#end()

"** Settings

"Theming
colorscheme gruvbox
set background=dark
hi Normal guibg=NONE ctermbg=NONE

"Indent based upon file's indentation
filetype plugin indent on

"Tabs to spaces and sizing
set tabstop=8
set expandtab
set shiftwidth=2
set softtabstop=2

"Use bash as internal shell
set shell=bash

"Always show line numbers
set number

"Display line at column width 80
set colorcolumn=80

"Don't word wrap in the middle of words
set wrap linebreak nolist

"Keep indentation aligned when line wrapping
set breakindent

"Automatically read newly updated file in buffer
set autoread

"Exclude anything in .gitignore from fuzzy find
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

"Fix editing crontab
au BufEnter /private/tmp/crontab.* setl backupcopy=yes

