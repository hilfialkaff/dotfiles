""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nu                        " Shows line numbers
" set tw=80                     " 80 chars in a line
set clipboard=unnamed         " Copying from terminal buffer
set wildmode=longest,list     " Display tab completion in nice format
set ruler                     " show the cursor position all the time
set showmatch                 " Cursor shows matching ) and }
set history=500               " Remember 500 past commands
set undolevels=1000           " Max number of undos
set cursorline                " Highlight current line
colorscheme jellybeans        " Colorscheme
syntax on                     " Colored programming syntax
filetype plugin on            " File specific config

" Indentation
set autoindent                " Auto indentation
set copyindent                " Copy the previous indentation on autoindenting

" Searching
set incsearch                 " Display all search occurences
set hlsearch                  " Highlight search occurrences
set smartcase                 " Ignore case if search pattern is all lowercase,case-sensitive otherwise

" Tabs
set ts=4                      " Set tabspacing to be 4
set expandtab                 " Expand tabs into spaces
set softtabstop=4             " Backspace -> delete 4 spaces

" Folds
set foldenable                " Enable folding
set foldlevelstart=0          " Start out with everything folded
set foldmethod=syntax         " Fold by per-language-syntax

" Being grammar nazi
setlocal spell spelllang=en_us
set thesaurus+=~/.vim/thesaurus/mthesaur.txt

" Enable omni completion.
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType java set omnifunc=javacomplete#Complete
" autocmd FileType cpp set omnifunc=cppcomplete#Complete

" use syntax complete if nothing else available
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
              \ if &omnifunc == "" |
              \ setlocal omnifunc=syntaxcomplete#Complete |
              \ endif
endif

" autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif " Eliminate trailing whitespaces

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

" Generate ctags for your C++ code
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" --- SuperTab
let g:SuperTabDefaultCompletionType = "context" " Use omnicompletion

" --- OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif " open/close preview window
set completeopt=menuone,menu,longest,preview
set tags+=~/.vim/tags/cpp
