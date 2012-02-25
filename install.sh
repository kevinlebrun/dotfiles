#!/usr/bin/env bash

install_dotfiles() {
    ln -sf ~/.smile/vim ~/.vim
    ln -sf ~/.smile/git/config ~/.gitconfig

    for dotfile in ~/.smile/.*
    do
        if [ -f "$dotfile" ]
        then
            ln -sf $dotfile ~/$(basename $dotfile)
        fi
    done

    mkdir -p ~/.ssh
    ln -sf ~/.smile/ssh/config ~/.ssh/config
}

install_dotfiles
