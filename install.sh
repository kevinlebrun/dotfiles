#!/usr/bin/env bash

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
SMILE_PATH="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# TODO install without download (private servers and rsync)

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
        curl "$2" -sLo "$1"
    elif which curl 1>/dev/null 2>&1; then
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

get_completion() {
    local file="$SMILE_PATH/bash_completion/$1"
    download "$2" "$file"
}

install_dotfiles

get_hg    .hg_prompt             http://bitbucket.org/sjl/hg-prompt/

get_bin   hub                    http://defunkt.io/hub/standalone # http://defunkt.io/hub/
get_bin   ack                    http://beyondgrep.com/ack-2.04-single-file
get_bin   cloc                   http://kent.dl.sourceforge.net/project/cloc/cloc/v1.60/cloc-1.60.pl
get_bin   git-publish-branch     http://git-wt-commit.rubyforge.org/git-publish-branch
get_bin   gbrt                   https://raw.github.com/benhoskings/dot-files/master/files/bin/gbrt
get_bin   git-cwd-info           https://raw.github.com/topfunky/zsh-simple/master/bin/git-cwd-info
get_bin   git-current-branch     https://raw.github.com/topfunky/zsh-simple/master/bin/git-current-branch
get_bin   git-churn              https://raw.github.com/garybernhardt/dotfiles/master/bin/git-churn
get_bin   git-divergence         https://raw.github.com/garybernhardt/dotfiles/master/bin/git-divergence
get_bin   git-rank-contributors  http://git-wt-commit.rubyforge.org/git-rank-contributors
get_bin   git-wtf                http://git-wt-commit.rubyforge.org/git-wtf
get_bin   git-thanks             https://gist.github.com/rkh/74335/raw/47397a6c7fc7d6bc10eef8d619a5e752e829e5c9/git-thanks
get_bin   git-trail              http://chneukirchen.org/dotfiles/bin/git-trail
get_bin   now                    https://raw.github.com/apankrat/now.sh/master/now.sh

get_completion vagrant           https://raw.github.com/kura/vagrant-bash-completion/master/vagrant
get_completion git               https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
get_completion ssh               https://raw.github.com/revans/bash-it/master/completion/available/ssh.completion.bash
get_completion tmux              https://raw.github.com/revans/bash-it/master/completion/available/tmux.completion.bash

if [ ! -f "$HOME/.tmux.local.conf" ]; then
    touch "$HOME/.tmux.local.conf"
fi

if [ -x "ruby" ]; then
    "$SMILE_PATH/vim/update_bundles.rb" --notrash
fi


echo "export SMILE=$SMILE_PATH" > "$HOME/.smile.conf"
