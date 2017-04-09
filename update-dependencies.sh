#!/usr/bin/env bash

get_hg() {
    if [ ! -x hg ]; then
        echo "Mercurial not found on the system"
        echo "Skipping $2 installation"
        return 1
    fi

    local dest="$HOME/$1"

    if [ ! -d "$dest" ]; then
        hg clone "$2" "$dest"
    elif $(hg --cwd "$dest" branch &> /dev/null); then
        hg --cwd "$dest" pull
        hg --cwd "$dest" update
    fi
}

download() {
    if which curl 1>/dev/null 2>&1; then
        echo "download: $1 ($2)"
        curl "$1" -sLo "$2"
    elif which wget 1>/dev/null 2>&1; then
        wget -qO "$1" "$2"
    else
        echo "Cannot download $2"
        return 1
    fi
}

get_bin() {
    local binfile="$SMILE_PATH/bin/$1"
    download "$2" "$binfile" && chmod +x "$binfile"
}

get_hg    .hg_prompt             https://bitbucket.org/sjl/hg-prompt/

get_bin   hub                    http://defunkt.io/hub/standalone # http://defunkt.io/hub/
get_bin   git-publish-branch     http://git-wt-commit.rubyforge.org/git-publish-branch
get_bin   gbrt                   https://raw.github.com/benhoskings/dot-files/master/files/bin/gbrt
get_bin   git-cwd-info           https://raw.github.com/topfunky/zsh-simple/master/bin/git-cwd-info
get_bin   git-current-branch     https://raw.github.com/topfunky/zsh-simple/master/bin/git-current-branch
get_bin   git-churn              https://raw.github.com/garybernhardt/dotfiles/master/bin/git-churn
get_bin   git-divergence         https://raw.github.com/garybernhardt/dotfiles/master/bin/git-divergence
get_bin   git-rank-contributors  http://git-wt-commit.rubyforge.org/git-rank-contributors
get_bin   git-wtf                http://git-wt-commit.rubyforge.org/git-wtf
get_bin   fresh-chrome           https://gist.github.com/stuartsierra/6220797/raw/af23e82e79125c6993a836ae9604e8c69518d265/fresh-chrome.sh
get_bin   git-trail              http://chneukirchen.org/dotfiles/bin/git-trail
get_bin   now                    https://raw.github.com/apankrat/now.sh/master/now.sh
get_bin   run-command-on-git-revisions https://raw.githubusercontent.com/garybernhardt/dotfiles/master/bin/run-command-on-git-revisions
get_bin   imgcat                 https://raw.githubusercontent.com/gnachman/iTerm2/master/tests/imgcat
