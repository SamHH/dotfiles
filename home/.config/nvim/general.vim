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

" Disable any expensive folding on load to improve performance of massive files
set foldmethod=manual
set nofoldenable

" Write swap file faster so that plugins like gitgutter are more responsive
set updatetime=50

" Always leave space for sign column so (dis)appearance of signs in a buffer
" doesn't cause the text to shift
set signcolumn=yes

" Live substitution
set inccommand=nosplit

" Highlight references to symbol under cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
