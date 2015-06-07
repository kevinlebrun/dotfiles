set nocompatible

" NeoBundle plugins {{{
set runtimepath+=~/.vim/bundle/neobundle.vim/

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc.vim', {'build': {'unix': 'make'}}

NeoBundle 'Valloric/YouCompleteMe' , {
    \ 'build' : {
    \    'unix' : './install.sh --clang-completer --system-libclang --omnisharp-completer',
    \    'mac' : './install.sh --clang-completer --system-libclang --omnisharp-completer'
    \ },
\ }
NeoBundle 'tpope/vim-sensible'
NeoBundle 'tpope/vim-sleuth'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'StanAngeloff/php.vim'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'bitc/lushtags'
NeoBundle 'bling/vim-airline'
NeoBundle 'chase/vim-ansible-yaml'
NeoBundle 'dag/vim2hs'
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'fatih/vim-go'
NeoBundle 'godlygeek/tabular'
NeoBundle 'goldfeld/vim-seek'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'reedes/vim-textobj-quote'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'klen/python-mode'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/gist-vim'
NeoBundle 'mbbill/undotree'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'rizzatti/dash.vim'
NeoBundle 'robmiller/vim-movar'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'sheerun/vim-polyglot'
NeoBundle 'sjl/clam.vim'
NeoBundle 'spf13/PIV'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-tbone'
NeoBundle 'ujihisa/neco-ghc'
NeoBundle 'vim-scripts/matchit.zip'
NeoBundle 'walm/jshint.vim'
NeoBundle 'tpope/vim-scriptease'

NeoBundle 'junegunn/goyo.vim'
NeoBundle 'junegunn/limelight.vim'
NeoBundle 'reedes/vim-pencil'
NeoBundle 'reedes/vim-lexical'
NeoBundle 'reedes/vim-wordy'

NeoBundle 'itspriddle/vim-marked'

NeoBundle 'maxbrunsfeld/vim-yankstack'

NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'

NeoBundle 'editorconfig/editorconfig-vim'

NeoBundle 'junegunn/vader.vim'

NeoBundle 'tpope/vim-vinegar'

call neobundle#end()
" }}}

set encoding=utf-8
set termencoding=utf-8

" Color Scheme - Solarized {{{
set background=dark
let g:solarized_visibility = "low"
let g:solarized_contrast = "high"

colorscheme solarized

if $COLORTERM == "gnome-terminal"
    set t_Co=16
elseif $TERM == "xterm-256color" || $TERM == "screen-256color"
    set t_Co=256
    let g:solarized_termcolors = 256
endif
" }}}

" tmux integration {{{
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

let mapleader=','
" }}}

" Defaults {{{
set hid

" turn backup off, since most stuff is in git anyway...
set nobackup
set noswapfile

set nopaste

set visualbell t_vb= " turn off error beep/flash
set novisualbell

set modeline " last lines in document sets vim mode
set modelines=3 " number lines checked for modelines

set undolevels=1000

if exists('+colorcolumn')
    set colorcolumn=121
endif

set cursorline " hightlight the current line
set title " show title in console title bar
set ttyfast " smoother changes

au VimEnter * silent! set winwidth=31
au VimEnter * silent! set winminwidth=31
au VimEnter * silent! set winheight=5 " hack against error setting winminheight
au VimEnter * silent! set winminheight=5
au VimEnter * silent! set winheight=999

set linespace=0 " no extra spaces between rows

set lazyredraw

set wildmode=longest,list
set wildignore+=*.o,*.obj,.git,*.pyc,.hg,node_modules,.sass-cache,vendor,dist

set nowrap

set smartindent

set magic
set ignorecase
set smartcase
set hlsearch
set incsearch

set tildeop " allow 3~

set cryptmethod=blowfish

set shortmess+=I

set list
set listchars=tab:▸\ ,trail:.,extends:❯,precedes:❮,nbsp:.,eol:¬
set showbreak=↪

set sm " show matching braces

set ww=b,s,<,>,[,]

set completeopt=menu,menuone,longest

set splitbelow
set splitright
" }}}

" wrapped lines goes down/up to next row, rather than next line in file
nnoremap j gj
nnoremap k gk

" reselect after shifting
vnoremap < <gv
vnoremap > >gv

nnoremap / /\v
vnoremap / /\v

inoremap jj <ESC>
cnoremap jj <C-c>

" force saving with permissions
cnoremap w!! w !sudo tee % > /dev/null

noremap <leader>cd :cd %:p:h<CR>:pwd<CR>
noremap <leader>a  :Ack
noremap <leader>ta :TagbarToggle<cr>
noremap <leader>n  :NERDTreeToggle<CR>
noremap <leader>e  :execute '!chmod +x %'<cr> :e!<cr>
noremap <leader>N  :set number!<cr>

" Editing text files (text, markdown, textile) {{{
augroup textobj_quote
    autocmd!
    autocmd FileType markdown call textobj#quote#init()
    autocmd FileType textile call textobj#quote#init()
    autocmd FileType text call textobj#quote#init({'educate': 0})
augroup END

augroup pencil
    autocmd!
    autocmd FileType markdown,mkd call pencil#init()
    autocmd FileType text         call pencil#init()
augroup END

augroup lexical
    autocmd!
    autocmd FileType markdown,mkd call lexical#init()
    autocmd FileType textile call lexical#init()
    autocmd FileType text call lexical#init({ 'spell': 0 })
augroup END
" }}}

" Better Vim help navigation {{{
augroup help
   autocmd!
   autocmd filetype help nnoremap <buffer><cr> <c-]>
   autocmd filetype help nnoremap <buffer><bs> <c-T>
augroup END
" }}}

" Bash style navigation in command mode {{{
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Delete>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>
cnoremap <C-g>  <C-c>
" }}}

" Abbreviations {{{
iabbrev @@ lebrun.k@gmail.com
iabbrev ccopy Copyright © 2015 Kevin Le Brun
iabbrev ssign -- <cr>Kevin Le Brun<cr>leburn.k@gmail.com
" }}}

" YankStack configuration {{{
nnoremap <leader>p <Plug>yankstack_substitute_older_paste
nnoremap <leader>P <Plug>yankstack_substitute_newer_paste
" }}}

" Ultisnips {{{
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}

" Snippets vars {{{
let g:snips_author = "Kevin Le Brun"
let g:snips_email = "lebrun.k@gmail.com"
let g:snips_github = "https://github.com/kevinlebrun"
" }}}

" Vim helpers {{{
" reload vimrc file with notification
noremap <silent> <leader>sv :source $MYVIMRC<CR>:filetype detect<CR>:echo 'vimrc reloaded'<CR>
noremap <leader>ev :vsplit $MYVIMRC<CR>

nnoremap <leader><leader>s :source %<cr>
vnoremap <leader>s y:execute @@<cr>

augroup filetype_vim
    autocmd!
    autocmd filetype vim set foldmethod=marker
augroup END
" }}}

" EasyAlign {{{
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vnoremap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nnoremap <Leader>a <Plug>(EasyAlign)
" }}}

" DashSearch (<leader>d) {{{
nnoremap <silent> <leader>d <Plug>DashSearch
" }}}

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
noremap <silent> <leader>S <esc>:keepjumps call CleanExtraSpaces()<cr>
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
noremap <leader>f :CtrlPMRU<CR>
noremap <leader>b :CtrlPBuffer<CR>

let g:ctrlp_follow_symlinks = 1
let g:ctrlp_working_path_mode = 'ra'
" }}}

" Zen Coding {{{
let g:user_zen_leader_key = '<c-e>'
let g:user_zen_complete_tag = 1
" }}}

" Clam {{{
nnoremap ! :Clam<space>
vnoremap ! :ClamVisual<space>
" }}}

" Markdown {{{
let g:markdown_fenced_languages = ['php', 'ruby', 'python', 'javascript', 'js=javascript', 'json=javascript', 'sh']
augroup markdown
   autocmd!
   autocmd FileType markdown setlocal nofoldenable
   autocmd FileType markdown noremap <leader>m :MarkedOpen!<cr>
augroup END
let g:marked_app = "Marked.app"
" }}}

" AutoComplete {{{
augroup complete
   autocmd!
   autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
   autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
   autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
   autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
   autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
   autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
augroup END
" }}}

" Undotree {{{
if has("persistent_undo")
    set undodir=$HOME.'/.undotree',
    set undofile
endif
" }}}

" python mode {{{
let g:pymode_folding = 0
let g:pymode_lint = 0
let g:pymode_lint_on_write = 0
let g:pymode_lint_on_fly = 0
let g:pymode_rope = 0
let g:pymode_syntax = 0
" }}}

" vim-go {{{
augroup golang
   autocmd!
   autocmd FileType go nnoremap <Leader>go <Plug>(go-def-split)
   autocmd FileType go nnoremap <Leader>re <Plug>(go-rename)
augroup END

let g:go_fmt_fail_silently = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
" }}}

" Airline {{{
let g:airline_powerline_fonts = 1
let g:airline_theme='simple'
let g:airline_enable_fugitive=1
" }}}

" Goyo.vim {{{
augroup goyo
    autocmd!
    autocmd User GoyoEnter Limelight
    autocmd User GoyoLeave Limelight!
augroup END
" }}}

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

NeoBundleCheck
