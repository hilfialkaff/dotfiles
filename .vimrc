set nu
set ts=4
set expandtab
syntax on
set incsearch
set clipboard=unnamed
set t_Co=256
colorscheme jellybeans
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
set hlsearch
set wildmode=longest,list

source /home/$USER/.vim/plugin/cscope_maps.vim

map <A-]>v :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]>h :sp <CR>:exec("tag ".expand("<cword>"))<CR>

filetype plugin on
