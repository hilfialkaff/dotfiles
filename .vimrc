""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nu                        " Shows line numbers
set tw=80                     " 80 chars in a line
set clipboard=unnamed         " Copying from terminal buffer
set wildmode=longest,list     " Display tab completion in nice format
set ruler                     " show the cursor position all the time
set showmatch                 " Cursor shows matching ) and }

" Indentation
set autoindent                " Auto indentation
set copyindent                " Copy the previous indentation on autoindenting

" Searching
set ignorecase                " Ignore case when searching
set incsearch                 " Display all search occurences
set hlsearch                  " Highlight search occurrences
set smartcase                 " Ignore case if search pattern is all lowercase,case-sensitive otherwise

" Tabs
set ts=4                      " Set tabspacing to be 4
set expandtab                 " Expand tabs into spaces

" Being grammar nazi
setlocal spell spelllang=en_us
set thesaurus+=/home/$USER/.vim/thesaurus/mthesaur.txt

" Enable omni completion.
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType java set omnifunc=javacomplete#Complete

" use syntax complete if nothing else available
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
              \ if &omnifunc == "" |
              \ setlocal omnifunc=syntaxcomplete#Complete |
              \ endif
endif

" Misc
colorscheme jellybeans              " Set colorscheme
syntax on                           " Colored programming syntax
filetype plugin on                  " File specific config

" autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif " Eliminate trailing whitespaces

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" cscope shortcuts
map <A-]>v :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]>h :sp <CR>:exec("tag ".expand("<cword>"))<CR>

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" --- Super Tab
let g:SuperTabDefaultCompletionType = "context" " Use omnicompletion
