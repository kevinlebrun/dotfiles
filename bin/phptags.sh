#!/bin/sh
cd /usr/share/php5/ZendFramework-1.11.6/library/

ctags-exuberant -f ~/.vimtags -h ".php" -R \
--exclude="\.svn" \
--exclude="\.git" \
--exclude="\.hg" \
--totals=yes \
--tag-relative=yes \
--PHP-kinds=+cfi \
--regex-PHP='/abstract\s+class\s+([^ ]+)/\1/c/' \
--regex-PHP='/interface\s+([^ ]+)/\1/i/' \
--regex-PHP='/(public\s+|static\s+|abstract\s+|protected\s+|private\s+)+function\s+([^
(]+)/\2/f/' \

cd /usr/share/php/
ctags-exuberant -f ~/.vimtags -h ".php" -a -R \
--exclude="\.svn" \
--exclude="\.git" \
--exclude="\.hg" \
--totals=yes \
--tag-relative=yes \
--PHP-kinds=+cfi \
--regex-PHP='/abstract\s+class\s+([^ ]+)/\1/c/' \
--regex-PHP='/interface\s+([^ ]+)/\1/i/' \
--regex-PHP='/(public\s+|static\s+|abstract\s+|protected\s+|private\s+)+function\s+([^
(]+)/\2/f/' \
