""""""""""""""""""""""""""""""""""""""""
" MyVimrc based on all good .vimrc i saw "
""""""""""""""""""""""""""""""""""""""""
set nocompatible

" plugin manager
call pathogen#infect()

syntax on
filetype plugin indent on

au filetype html set omnifunc=htmlcomplete#CompleteTags
au filetype css set omnifunc=csscomplete#CompleteCSS
au FileType python set omnifunc=pythoncomplete#Complete

"au BufReadPost,BufNewFile *.feature,*.story set filetype=cucumber
let feature_filetype='behat'
au BufReadPost,BufNewFile *.phtml set filetype=php.html

set encoding=utf-8
set termencoding=utf-8

" use original theme molokai
let g:molokai_original = 1

if has("gui_running")
    set background=light
    colorscheme solarized
    set mousehide
    set guioptions=ce
    set guioptions-=m
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 11,Fixed\ 11
    set columns=80
    set lines=40
else
    colorscheme molokai
    set t_Co=256
endif

au BufWinLeave * silent! mkview " make vim save view state
au BufWinEnter * silent! loadview " make vim load view state

set hid

" turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set noswapfile

set nopaste

set visualbell t_vb= " turn off error beep/flash
set novisualbell

set modeline " last lines in document sets vim mode
set modelines=3 " number lines checked for modelines

set history=500 "lines of history VIM has to remember
set undolevels=1000

set cursorline " hightlight the current line
set number " show line numbers
set ruler " show the current position
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
set title " show title in console title bar
set ttyfast " smoother changes

au VimEnter * set winwidth=31
au VimEnter * set winminwidth=31
au VimEnter * set winheight=5 " hack against error setting winminheight
au VimEnter * set winminheight=5
au VimEnter * set winheight=999

set laststatus=2 " always show the status line
" Broken down into easily includeable segments
set statusline=%<%f\  " Filename
set statusline+=%w%h%m%r " Options
set statusline+=%{fugitive#statusline()} " Git Hotness
set statusline+=\ [%{&ff}/%Y] " filetype
set statusline+=\ [%{getcwd()}] " current dir
"set statusline+=\ [A=\%03.3b/H=\%02.2B] " ASCII / Hexadecimal value of char
set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info

set linespace=0 " no extra spaces between rows

set cmdheight=2
set showcmd

set shellcmdflag=-ic

set lazyredraw

set wildmenu
set wildmode=longest,list
set wildignore+=*.pyc,**/build/**,log/**

" set to auto read when a file is changed from the outside
set autoread

set scrolloff=3 "leave few lines on top

set backspace=indent,eol,start

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

set nowrap
" set textwidth=90

set smartindent
set autoindent

set magic
set ignorecase
set smartcase
set hlsearch
set incsearch
nnoremap / /\v
vnoremap / /\v
nmap <silent> <C-N> :silent noh<CR>

set list
set listchars=tab:▸\ ,trail:.,extends:#,nbsp:.,eol:¬

set foldenable

set sm " show matching braces

set ww=b,s,<,>,[,]

" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

let mapleader=','

map <F2> :NERDTreeToggle<CR>
map <F5> yyp!!sh<cr>

" autocompletion shortcut
ino <S-space> <C-x><C-o>
set completeopt=menu,menuone,longest

no <leader>w :w<CR>
no <leader>q :q<CR>
" force saving with permissions
cmap w!! w !sudo tee % > /dev/null

" change working directory to the current file directory
no <leader>cd :cd %:p:h<CR>:pwd<CR>
map <leader>m :make<CR>
no <leader>a :Ack 
no <leader>u :GundoToggle<CR>
no <leader>ta :TagbarToggle<cr>
no <leader>nd :NERDTreeToggle 

" moving around windows
map <C-W>h <C-W>h:call ResizeWindow()<CR>ze
map <C-W>j <C-W>j<C-W>_
map <C-W>k <C-W>k<C-W>_
map <C-W>l <C-W>l:call ResizeWindow()<CR>ze

fun! ResizeWindow()
    if empty(&bt)
        :vertical res
    elseif &bt == "nofile" && winwidth(0) < 31
        " NERDTree & co. splits
        :vertical res 31
    endif
endfunction

" wrapped lines goes down/up to next row, rather than next line in file
nnoremap j gj
nnoremap k gk

map <right> :bn<cr>
map <left> :bp<cr>
map <up> <nop>
map <down> <nop>

" reselect after shifting
vno < <gv
vno > >gv

" help
au filetype help nno <buffer><cr> <c-]>
au filetype help nno <buffer><bs> <c-T>
"
" resize windows
map - <C-W>-
map + <C-W>+
map <M-,> <C-W>>
map <M-.> <C-W><
nmap <C-i> :vertical res 120<CR>

ino jj <ESC>
cno jj <C-c>

"""""""""""""""""""
" editing shortcuts
"""""""""""""""""""
" Move a line of text using ALT+[jk], see :help mz
nmap <C-down> mz:m+<cr>`z
nmap <C-up> mz:m-2<cr>`z
vmap <C-down> :m'>+<cr>`<my`>mzgv`yo`z
vmap <C-up> :m'<-2<cr>`>my`<mzgv`yo`z
imap <leader>; <esc>A;

"---------------------------------------------------------------------------
" Search for <cword> and replace with input() in all open buffers
"---------------------------------------------------------------------------
"
fun! Replace()
    let s:word = input("Replace " . expand('<cword>') . " with:")
    :exe 'bufdo! %s/' . expand('<cword>') . '/' . s:word . '/ge'
    :unlet! s:word
endfun

map <leader>r :call Replace()<CR>

" Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

" reload vimrc file with notification
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Clean all end of line extra whitespace with ,S
" Credit: voyeg3r https://github.com/mitechie/pyvim/issues/#issue/1
" deletes excess space but maintains the list of jumps unchanged
" for more details see: h keepjumps
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
map <silent><leader>S <esc>:keepjumps call CleanExtraSpaces()<cr>

" automatically give executable permissions if file begins with #! and contains '/bin/' in the path
function! MakeScriptExecutable()
    if getline(1) =~ "^#!.*/bin/"
        silent !chmod +x <afile>
    endif
endfunction
au BufWritePost * call MakeScriptExecutable()

" Tabularize mappings
nmap <leader>a= :Tabularize /=<CR>
vmap <leader>a= :Tabularize /=<CR>
nmap <leader>a: :Tabularize /:\zs<CR>
vmap <leader>a: :Tabularize /:\zs<CR>
nmap <leader>a> :Tabularize /=><CR>
vmap <leader>a> :Tabularize /=><CR>
nmap <leader>T :Tabularize /
vmap <leader>T :Tabularize /


" CtrlP
no <leader>o :CtrlP<CR>
map <leader>f :CtrlPMRU<CR>
map <leader>p :CtrlPBuffer<CR>
set wildignore+=*.o,*.obj,.git,*.pyc,.hg,node_modules,.sass-cache,vendor

" set tags=./tags;/,$HOME/.vimtags
set tags=./tags;/
" Load a tag file
" Loads a tag file from ~/.vim.tags/, based on the argument provided. The
" " command "Ltag"" is mapped to this function.
function! LoadTags(file)
   let tagspath = $HOME . "/.vimtags/" . a:file
   let tagcommand = 'set tags+=' . tagspath
   execute tagcommand
endfunction
command! -nargs=1 Ltag :call LoadTags("<args>")

let g:snips_author = 'Kevin Le Brun <lebrun.k@gmail.com>'

" Shortcut for reloading snippets, useful when developing
nnoremap ,smr <esc>:exec ReloadAllSnippets()<cr>

let NERDTreeIgnore = ['\.swp', '\.git$', '\.hg$', '\.svn', '\.sass-cache', 'node_modules', 'build$']
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden = 1
let NERDTreeKeepTreeInNewTab = 1
let NERDTreeShowBookmarks = 1
let NERDTreeChDirMode = 2

let g:gist_show_privates = 1
let g:gist_private = 1

let g:ctrlp_working_path_mode = 0

" use local vimrc if available
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
