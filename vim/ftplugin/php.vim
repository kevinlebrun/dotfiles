call LoadTags('zf1')
call LoadTags('phpunit')

setl omnifunc=phpcomplete#CompletePHP

setl textwidth=80
setl makeprg=php\ %
map <leader>l :php\ -l\ %
setl formatoptions=qroct

if !exists("g:DisableAutoPHPFolding")
    let g:DisableAutoPHPFolding = 0
endif

if !g:DisableAutoPHPFolding
    " Don't use the PHP syntax folding
    setlocal foldmethod=manual
    " Turn on PHP fast folds
    EnableFastPHPFolds
endif

" The completion dictionary is provided by Rasmus:
" http://lerdorf.com/funclist.txt
setl dictionary-=~/.vim/ftplugin/php-funclist.txt dictionary+=~/.vim/ftplugin/php-funclist.txt
setl dictionary-=~/.vim/ftplugin/php-xdebug2.txt dictionary+=~/.vim/ftplugin/php-xdebug2.txt
" Use the dictionary completion
setl complete-=k complete+=k

" Fix matchpairs for PHP (for matchit.vim plugin)
if exists("loaded_matchit")
    let b:match_skip = 's:comment\|string'
    let b:match_words = '<?\(php\)\?:?>,\<switch\>:\<endswitch\>,' .
        \ '\<if\>:\<elseif\>:\<else\>:\<endif\>,' .
        \ '\<while\>:\<endwhile\>,\<do\>:\<while\>,' .
        \ '\<for\>:\<endfor\>,\<foreach\>:\<endforeach\>' .
        \ '<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,' .
        \ '<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,' .
        \ '<\@<=\([^/?][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>,' .
        \ '<:>,(:),{:}'
endif

" Integrate PHP Codesniffer
function! RunPhpcs()
    let l:filename=@%
    let l:phpcs_output=system('phpcs --report=csv --standard=Zend '.l:filename)
    let l:phpcs_list=split(l:phpcs_output, "\n")
    unlet l:phpcs_list[0]
    cexpr l:phpcs_list
    copen
endfunction
command! Phpcs execute RunPhpcs()
map <leader>cs :Phpcs<CR>

imap <leader>vd var_dump();<esc>hi
imap <leader>el error_log();<esc>hi
imap <leader>elv error_log(var_export($data), true));<esc>F$vww

let php_sql_query=1
let php_htmlInStrings=1
let php_noShortTags=1
let php_folding=1
let php_parent_error_close = 1
let php_parent_error_open = 1

vmap <leader>pd :call PhpDocRange()<cr>
nmap <leader>pd :call PhpDocSingle()<cr>

func! LaunchPHPManual()
    let l:cmd='firefox http://www.php.net/' . expand('<cword>')
    exec "!" . l:cmd
endfunction
inoremap <leader>H <esc>:call LaunchPHPManual()<cr><cr>
nnoremap <leader>H <esc>:call LaunchPHPManual()<cr><cr>
