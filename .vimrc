" Shows line numbers
set nu

" Set tabspacing to be 4
set ts=4

" Expand tabs into spaces
set expandtab

" Colored programming syntax
syntax on

" Display all search occurences
set incsearch

" Highlight search occurrences
set hlsearch

" Copying in vim is stored in the computer buffer instead of the internal vim
" buffer
set clipboard=unnamed

" Eliminate trailing whitespaces
" autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Spellcheck (Currently set to English language)
" setlocal spell spelllang=en_us

" Set thesaurus
set thesaurus+=/home/$USER/.vim/thesaurus/mthesaur.txt

" Set colorscheme
colorscheme jellybeans

set wildmode=longest,list

" Cscope shortcuts
map <A-]>v :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]>h :sp <CR>:exec("tag ".expand("<cword>"))<CR>

filetype plugin on
