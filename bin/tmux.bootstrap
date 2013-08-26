#!/bin/bash

set -e -u

shopt -s nullglob extglob

for script in $HOME/.tmux.d/*.active
do
    name=${script##*/}
    name=${name%%.active}
    echo "executing $name..."
    "$script"
done
