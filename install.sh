#!/usr/bin/env bash

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
SMILE_PATH="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function install_dotfiles {
    ln -sf ${SMILE_PATH}/vim ~/.vim

    for dotfile in ${SMILE_PATH}/.*
    do
        if [ -f "$dotfile" ]
        then
            ln -sf $dotfile ~/$(basename $dotfile)
        fi
    done

    mkdir -p ~/.ssh
    ln -sf ${SMILE_PATH}/ssh/config ~/.ssh/config
}

function install_hg_prompt {
    hg clone http://bitbucket.org/sjl/hg-prompt/ ~/.hg_prompt
}

install_dotfiles
install_hg_prompt

echo "export SMILE=$SMILE_PATH" > ~/.smile.conf
