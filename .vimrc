""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
set backspace=indent,eol,start   " Ensure backspace is enabled
set nu                           " Shows line numbers
" set tw=80                        " 80 chars in a line
set clipboard=unnamed            " Copying from terminal buffer
set wildmode=longest,list        " Display tab completion in nice format
set ruler                        " show the cursor position all the time
set showmatch                    " Cursor shows matching ) and }
set history=500                  " Remember 500 past commands
set undolevels=1000              " Max number of undos
set cursorline                   " Highlight current line
colorscheme jellybeans           " Colorscheme
syntax on                        " Colored programming syntax
filetype plugin on               " File specific config

" Indentation
set autoindent                   " Auto indentation
set copyindent                   " Copy the previous indentation on autoindenting

" Searching
set incsearch                    " Display all search occurences
set hlsearch                     " Highlight search occurrences
set smartcase                    " Ignore case if search pattern is all lowercase,case-sensitive otherwise

" Tabs
set ts=4                         " Set tabspacing to be 4
set expandtab                    " Expand tabs into spaces
set softtabstop=4                " Backspace -> delete 4 spaces

" Folds
set foldenable                   " Enable folding
set foldlevelstart=0             " Start out with everything folded
set foldmethod=syntax            " Fold by per-language-syntax

" Being grammar nazi
" set spell
" setlocal spell spelllang=en_us
" set thesaurus+=~/.vim/thesaurus/mthesaur.txt

" Enable omni completion.
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType java set omnifunc=javacomplete#Complete
" autocmd FileType cpp set omnifunc=cppcomplete#Complete

" use syntax complete if nothing else available
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
    if &omnifunc == "" |
        setlocal omnifunc=syntaxcomplete#Complete |
    endif
endif

autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif " Eliminate trailing whitespaces

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set leader to ,
let mapleader=","
let g:mapleader=","

" If we forget to open file with sudo
cmap w!! w !sudo tee % > /dev/null

" Find all todo like a bauss
noremap <Leader>t :noautocmd vimgrep /TODO/j **/*\.[chsS] **/*\.py **\*.html <CR>:cw<CR>

" ctrl-jklm changes to Vim split
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l
noremap <c-h> <c-w>h

" cscope shortcuts
map <A-]>v :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]>h :sp <CR>:exec("tag ".expand("<cword>"))<CR>

" Folding
nnoremap <Space> zA
vnoremap <Space> zA
nnoremap <c-x> za
vnoremap <c-x> za

" open/close the quickfix window
nmap <leader>c :copen<CR>
nmap <leader>cc :cclose<CR>

" Tabs
noremap <silent> <S-l> :tabnext<CR>
noremap <silent> <S-h> :tabprevious<CR>
noremap <silent> <S-t> :tabnew<CR>
noremap <silent> <S-w> :tabclose<CR>

" Blackhole register
noremap <c-d> "_

" Epic shortcut to load your last session
nmap <F3> <ESC>:call LoadSession()<CR>
let s:sessionloaded = 0
function LoadSession()
  source Session.vim
  let s:sessionloaded = 1
endfunction
function SaveSession()
  if s:sessionloaded == 1
    mksession!
  end
endfunction
autocmd VimLeave * call SaveSession()

" Auto-create non-existing directory when opening a file
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p ".shellescape(expand('%:h'), 1) | redraw! | endif
augroup END

" Generate ctags for your C++ code
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set tags+=~/.vim/tags/cpp

" Load pylint code plugin (Seems not stable enough)
let g:pymode_lint = 0

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bundle 'Valloric/YouCompleteMe'
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt=menuone,menu,longest,preview

Bundle 'Raimondi/delimitMate'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'marijnh/tern_for_vim'
Bundle 'pangloss/vim-javascript'
Bundle "lepture/vim-jinja"
