""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle begin configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                    " be iMproved, required
filetype off                        " required
set rtp+=/Users/halkaff/.vim/bundle/Vundle.vim
call vundle#begin()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins (Run +PluginInstall first)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'gmarik/Vundle.vim'                          " Main vundle plugin
Plugin 'Raimondi/delimitMate'                       " Insert matching braces
Plugin 'airblade/vim-gitgutter'                     " Git diff inside Vim
Plugin 'pangloss/vim-javascript'                    " Javascript syntax
Plugin 'lepture/vim-jinja'                          " Jinja syntax
Plugin 'vim-scripts/Rename'                         " File renaming
Plugin 'tpope/vim-fugitive'                         " Git command
Plugin 'Lokaltog/vim-easymotion'                    " Easy words navigation
Plugin 'scrooloose/nerdtree'                        " File navigation
    map <C-n> :NERDTreeToggle<CR>
Plugin 'Lokaltog/powerline-fonts'                   " Fonts for status line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
    set laststatus=2
    let g:airline#extensions#tabline#enabled=0
    let g:airline_powerline_fonts=1
    let g:airline#extensions#tabline#enabled=1
    let g:airline_theme='molokai'
    let g:airline_left_sep='▶'
    function! AirlineInit()
        let g:airline_section_a = airline#section#create(['mode', ' ', 'branch'])
        let g:airline_section_b = airline#section#create_left(['ffenc', 'hunks', '%f'])
        let g:airline_section_c = airline#section#create(['filetype'])
        let g:airline_section_x = airline#section#create(['%P'])
        let g:airline_section_y = airline#section#create(['%B'])
        let g:airline_section_z = airline#section#create_right(['%l', '%c'])
    endfunction
    autocmd VimEnter * call AirlineInit()
Plugin 'klen/python-mode'                           " Python goodness
    let g:pymode_lint_on_write=0
    let g:pymode_rope_complete_on_dot=0
    let g:pymode_lint_checkers=['pyflakes', 'mccabe']
Plugin 'kien/ctrlp.vim'                             " Fuzzy-finder file
    set wildignore+=*/tmp/*,*.so,*.swp
    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/](venv|\.(git|hg|svn))$'
      \ }
Plugin 'gregsexton/MatchTag'                        " HTML tag highlighting
Plugin 'Shougo/neocomplcache.vim'                   " Autocompletion
    let g:neocomplcache_enable_at_startup=1
    let g:neocomplcache_enable_smart_case=1
    let g:neocomplcache_enable_camel_case_completion=1
    let g:neocomplcache_enable_underbar_completion=1
    let g:neocomplcache_min_syntax_lengthl=0
    let g:neocomplcache_lock_buffer_name_pattern='\*ku\*'
Plugin 'ervandew/supertab'                          " TAB for auto-completion
    let g:SuperTabDefaultCompletionType = "<c-n>"   " Top-down scroll

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle end configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call vundle#end()            " required
filetype plugin indent on    " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set backspace=indent,eol,start   " Ensure backspace is enabled
set nu                           " Shows line numbers
set tw=80                        " 80 chars in a line
set cc=80                        " Indicates the 80 chars limit
set clipboard=unnamed            " Copying from terminal buffer
set wildmode=longest,list        " Display tab completion in nice format
set ruler                        " show the cursor position all the time
set showmatch                    " Cursor shows matching ) and }
set history=500                  " Remember 500 past commands
set undolevels=1000              " Max number of undos
set cursorline                   " Highlight current line
set relativenumber               " Relative line numbering
colorscheme jellybeans           " Colorscheme
syntax on                        " Colored programming syntax

" Indentation
set autoindent                   " Auto indentation
set copyindent                   " Copy the previous indentation

" Searching
set incsearch                    " Display all search occurences
set hlsearch                     " Highlight search occurrences
set smartcase                    " Ignore case if search pattern is lowercase

" Tabs
set ts=4                         " Set tabspacing to be 4
set expandtab                    " Expand tabs into spaces
set softtabstop=4                " Backspace -> delete 4 spaces

" Folds
set foldenable                   " Enable folding
set foldlevelstart=0             " Start out with everything folded
set foldmethod=syntax            " Fold by per-language-syntax

set guifont=Inconsolata/Inconsolata\ for\ Powerline.otf

" Being grammar nazi
set spell
setlocal spell spelllang=en_us
" set thesaurus+=~/.vim/thesaurus/mthesaur.txt
set completeopt=menuone,menu,longest,preview

autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif " Eliminate trailing whitespaces

" Omni-completion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set leader to ,
let mapleader=","
let g:mapleader=","

" If we forget to open file with sudo
cmap w!! w !sudo tee % > /dev/null

" Find all todo like a bauss
noremap <Leader>t :noautocmd vimgrep /TODO/j **/*\.[ch] **/*\.py **\*.html <CR>:cw<CR>

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
" noremap <c-d> "_

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
    autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' &&
        \ !isdirectory(expand("%:h")) | execute
        \ "silent! !mkdir -p ".shellescape(expand('%:h'), 1) | redraw! | endif
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File-specific
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd filetype javascript,css,html setlocal autoindent
autocmd filetype javascript,css,html setlocal shiftwidth=2
autocmd filetype javascript,css,html setlocal ts=2
autocmd filetype javascript,css,html setlocal softtabstop=2
