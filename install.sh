#!/usr/bin/env bash

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
SMILE_PATH="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

install_dotfiles() {
    if [ ! -d "$HOME/.vim" ]; then
        ln -s "${SMILE_PATH}/vim" "$HOME/.vim"
    fi

    for dotfile in "${SMILE_PATH}"/.*
    do
        if [ -f "$dotfile" ]
        then
            ln -sf "$dotfile" "$HOME/$(basename "$dotfile")"
        fi
    done
}

install_dotfiles

if [ ! -f "$HOME/.tmux.local.conf" ]; then
    touch "$HOME/.tmux.local.conf"
fi

echo "export SMILE=$SMILE_PATH" > "$HOME/.smile.conf"

