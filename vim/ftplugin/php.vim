setl omnifunc=phpcomplete#CompletePHP

setl formatoptions=qroct

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

let php_sql_query=1
let php_htmlInStrings=1
let php_parent_error_close = 1
let php_parent_error_open = 1
