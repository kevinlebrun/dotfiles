#!/usr/bin/env bash

install_dotfiles() {
    ln -sf ~/.smile/dotfiles/vim ~/.vim
    ln -sf ~/.smile/dotfiles/git/config ~/.gitconfig

    for dotfile in ~/.smile/dotfiles/.*
    do
        if [ -f "$dotfile" ]
        then
            ln -sf $dotfile ~/$(basename $dotfile)
        fi
    done

    mkdir -p ~/.ssh
    ln -sf ~/.smile/dotfiles/ssh/config ~/.ssh/config
}

install_dotfiles
