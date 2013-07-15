" vim:fdm=marker

set nocompatible

call pathogen#infect()

syntax on
filetype plugin indent on

au filetype html setlocal omnifunc=htmlcomplete#CompleteTags
au filetype css setlocal omnifunc=csscomplete#CompleteCSS
au FileType python setlocal omnifunc=pythoncomplete#Complete

let feature_filetype='behat'
au BufReadPost,BufNewFile *.phtml setlocal filetype=php.html

set encoding=utf-8
set termencoding=utf-8

set background=dark

if $COLORTERM == "gnome-terminal"
    set t_Co=16
elseif $TERM == "xterm-256color" || $TERM == "screen-256color"
    set t_Co=256
    let g:solarized_termcolors = 256
endif

" solarized options
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
colorscheme solarized

if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

"let g:molokai_original = 1
"colorscheme molokai

set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

let g:Powerline_theme="skwp"
let g:Powerline_colorscheme="skwp"

let g:Powerline_symbols = 'fancy'
let g:Powerline_cache_file = expand("~/.vim/.Powerline.cache")

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

if exists('+colorcolumn')
    set colorcolumn=121
endif

set cursorline " hightlight the current line
set number " show line numbers
set ruler " show the current position
set title " show title in console title bar
set ttyfast " smoother changes

au VimEnter * set winwidth=31
au VimEnter * set winminwidth=31
au VimEnter * set winheight=5 " hack against error setting winminheight
au VimEnter * set winminheight=5
au VimEnter * set winheight=999

set laststatus=2 " always show the status line

set linespace=0 " no extra spaces between rows

set showcmd

set shell=bash
"set shell=zsh\ -i
"set shellcmdflag=-ic

set lazyredraw

set wildmenu
set wildmode=longest,list
set wildignore+=*.o,*.obj,.git,*.pyc,.hg,node_modules,.sass-cache,vendor

set autoread

set scrolloff=3

set backspace=indent,eol,start

" TODO define for specific files
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

set nowrap

set smartindent
set autoindent

set magic
set ignorecase
set smartcase
set hlsearch
set incsearch

set tildeop " allow 3~

nnoremap / /\v
vnoremap / /\v

nmap <silent> <C-N> :silent noh<CR>

set list
set listchars=tab:▸\ ,trail:.,extends:❯,precedes:❮,nbsp:.,eol:¬
set showbreak=↪

set sm " show matching braces

set ww=b,s,<,>,[,]

autocmd FileType php,phtml,css,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call CleanTrailingSpacesAndMChars()
fun! CleanTrailingSpacesAndMChars()
    call setline(1, map(getline(1, "$"), 'substitute(v:val,"\\s\\+$","","")'))
endfun

let mapleader=','

set completeopt=menu,menuone,longest

no <leader>w :w<CR>
no <leader>q :q<CR>
no <leader>s :sus<CR>
" force saving with permissions
cmap w!! w !sudo tee % > /dev/null
map <leader>e :execute '!chmod +x %'<cr> :e!<cr>

" change working directory to the current file directory
no <leader>cd :cd %:p:h<CR>:pwd<CR>
no <leader>a :Ack
no <leader>u :GundoToggle<CR>
no <leader>ta :TagbarToggle<cr>
map <leader>n :NERDTreeToggle<CR>

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

set splitbelow
set splitright

" wrapped lines goes down/up to next row, rather than next line in file
nnoremap j gj
nnoremap k gk

" reselect after shifting
vno < <gv
vno > >gv

au filetype help nno <buffer><cr> <c-]>
au filetype help nno <buffer><bs> <c-T>
"
" resize windows
map - <C-W>-
map + <C-W>+
map <M-,> <C-W>>
map <M-.> <C-W><
nmap <C-i> :vertical res 121<CR>

nmap <leader><leader>o :vs ~/Dropbox/Workspace/scratch.markdown<cr>
nmap <leader><leader>p :vs ~/Dropbox/Workspace/pomodoro.markdown<cr>
nmap <leader><leader>l :vs ~/Dropbox/Workspace/log.markdown<cr>

cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Delete>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>
cnoremap <C-g>  <C-c>

noremap <left> :tabp<cr>
noremap <right> :tabn<cr>
noremap <up> :tabr<cr>
noremap <down> :tabl<cr>

ino jj <ESC>
cno jj <C-c>

map SS :set sw=4 ts=4 sts=4<CR>

" Search for <cword> and replace with input() in all open buffers {{{
fun! Replace()
    let s:word = input("Replace " . expand('<cword>') . " with:")
    :exe 'bufdo! %s/' . expand('<cword>') . '/' . s:word . '/ge'
    :unlet! s:word
endfun
map <leader>r :call Replace()<CR>
" }}}

" reload vimrc file with notification
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
map <leader>vi :e ~/.vimrc<CR>
map <leader>vm :e ~/.vim/update_bundles.rb<CR>

" Clean all end of line extra whitespace with ,S {{{
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
" }}}

" Tabularize {{{
nmap <leader>a: :Tabularize /:\zs<CR>
vmap <leader>a: :Tabularize /:\zs<CR>
nmap <leader>T :Tabularize /
vmap <leader>T :Tabularize /
" }}}

" Tags {{{
set tags=./tags;/
function! LoadTags(file)
   let tagspath = $HOME . "/.vimtags/" . a:file
   let tagcommand = 'set tags+=' . tagspath
   execute tagcommand
endfunction
command! -nargs=1 Ltag :call LoadTags("<args>")
" }}}

" NERDTree {{{
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden = 1
let NERDTreeKeepTreeInNewTab = 1
let NERDTreeShowBookmarks = 1
let NERDTreeChDirMode = 2
" }}}

" Gist {{{
let g:gist_show_privates = 1
let g:gist_private = 1
" }}}

" CtrP {{{
map <leader>f :CtrlPMRU<CR>
map <leader>b :CtrlPBuffer<CR>

let g:ctrlp_follow_symlinks = 1
let g:ctrlp_working_path_mode = 'ra'
" }}}

" Zen Coding {{{
let g:user_zen_settings = {
\  'indentation' : "    "
\}
let g:user_zen_leader_key = '<c-e>'
let g:user_zen_complete_tag = 1
" }}}

" Clam {{{
nnoremap ! :Clam<space>
vnoremap ! :ClamVisual<space>
" }}}

" Markdown {{{
let g:markdown_fenced_languages = ['php', 'ruby', 'python', 'javascript', 'js=javascript', 'json=javascript', 'sh=bash', 'sh']
au FileType markdown setlocal nofoldenable
au FileType markdown noremap <leader>m :silent !open -a Marked.app '%:p'<cr>
" }}}


if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
