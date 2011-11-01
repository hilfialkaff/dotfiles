set nu
set ts=4
set expandtab
syntax on
set incsearch
set clipboard=unnamed
colorscheme jellybeans
" set ignorecase
set hlsearch
set wildmode=longest,list

" Only enable when needed
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

set path=/home/aurum/.vim/plugin/
source /home/aurum/.vim/plugin/cscope_maps.vim

map <A-]>v :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]>h :sp <CR>:exec("tag ".expand("<cword>"))<CR>

filetype plugin on
