setl omnifunc=phpcomplete#CompletePHP
setl textwidth=79
setl makeprg=php\ -l\ %
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
