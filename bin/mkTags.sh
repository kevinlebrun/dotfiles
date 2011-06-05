#!/bin/sh
# Strongly based on Matthew Weier O'Phinney matthew work
# Create tags for a PHP library.
# Can be called as follows:
# 
# - mkTags
#   Will then prompt for a directory and the "alias" (i.e., tag file name) you
#   wish to scan.
# - mkTags [dir]
#   Will scan the directory chosen, using its basename as the alias (i.e., tag
#   file name).
# - mkTags [dir] [alias]
# 
# Tags are created in $HOME/.vim.tags/
dest=$HOME/.vimtags

dir=""
name=""
if [ $# -ge 2 ] ; then
    # Two arguments: first is directory, second is "alias"
    dir=$1
    name=$2
else
    if [ $# -eq 1 ] ; then
        # One argument: use as directory, and use basename of directory as alias
        dir=$1
        name=`basename $1`
    else
        # Otherwise: prompt
        echo "Enter the path to a directory containing PHP code you wish"
        echo "to create tags for:"
        read dir
        echo "Enter the name of the tagfile you wish to create:"
        read name
    fi
fi

echo "Creating tags for directory '$dir' using alias '$name'"
cd $dir
exec ctags-exuberant -f "$dest/$name" \
-h ".php" -R \
--exclude="\.svn" \
--exclude="\.git" \
--exclude="\.hg" \
--totals=yes \
--tag-relative=yes \
--fields=+afkst \
--PHP-kinds=+cf
echo "[DONE]"
