" Always show line numbers
set number

" Display line at column width 80
set colorcolumn=80

" Don't word wrap in the middle of words
set wrap linebreak nolist

" Keep indentation aligned when line wrapping
set breakindent

" Allow hidden buffers (for coc)
set hidden

" Automatically read newly updated file in buffer
set autoread

" Disable folding on load by default to improve performance in massive files
set nofoldenable
set foldmethod=manual

" Write swap file faster so that plugins like gitgutter are more responsive
set updatetime=50

" Display signs in number column
set signcolumn=number

" Live substitution
set inccommand=nosplit

" Remove default scratch/preview window from autocomplete
set completeopt=menuone,noinsert

augroup TerminalBehavior
  " Remove number/sign columns in terminal
  autocmd TermOpen * setlocal nonumber signcolumn=no
  " Immediately enter insert mode in terminal
  autocmd TermOpen * startinsert
augroup END

