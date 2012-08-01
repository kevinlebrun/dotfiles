#!/usr/bin/env bash

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
SMILE_PATH="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

install_vcprompt() {
    curl -sL https://https://github.com/djl/vcprompt/raw/master/bin/vcprompt > ${SMILE_PATH}/bin/vcprompt
}

install_dotfiles() {
    ln -sf ${SMILE_PATH}/vim ~/.vim
    ln -sf ${SMILE_PATH}/git/config ~/.gitconfig

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

install_dotfiles
install_vcprompt

echo "export SMILE=$SMILE_PATH" > ~/.smile.conf
