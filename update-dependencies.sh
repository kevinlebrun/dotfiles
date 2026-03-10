#!/usr/bin/env bash

download() {
    if which curl 1>/dev/null 2>&1; then
        echo "download: $1 ($2)"
        curl --max-time 15 "$1" -sLo "$2"
    elif which wget 1>/dev/null 2>&1; then
        wget -qO "$2" "$1"
    else
        echo "Cannot download $2"
        return 1
    fi
}

get_bin() {
    local binfile="$HOME/dotfiles/bin/$1"
    download "$2" "$binfile" && chmod +x "$binfile"
}

get_bin   git-churn              https://raw.githubusercontent.com/garybernhardt/dotfiles/master/bin/git-churn
get_bin   git-divergence         https://raw.githubusercontent.com/garybernhardt/dotfiles/master/bin/git-divergence
get_bin   run-command-on-git-revisions https://raw.githubusercontent.com/garybernhardt/dotfiles/master/bin/run-command-on-git-revisions
get_bin   imgcat                 https://iterm2.com/utilities/imgcat
get_bin   xml2json               https://raw.githubusercontent.com/hay/xml2json/master/xml2json.py
get_bin   structurer             https://raw.githubusercontent.com/kevinlebrun/structurer/master/structurer
