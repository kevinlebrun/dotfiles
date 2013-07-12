#!/usr/bin/env bash

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
SMILE_PATH="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function install_dotfiles {
    if [ ! -d ~/.vim ]; then
        ln -s ${SMILE_PATH}/vim ~/.vim
    fi

    for dotfile in ${SMILE_PATH}/.*
    do
        if [ -f "$dotfile" ]
        then
            ln -sf $dotfile ~/$(basename $dotfile)
        fi
    done
}

function hg_clone {
    if [ ! -d "$1" ]; then
        hg clone "$2" "$1"
    fi
}

function get_bin {
    local binfile="$SMILE_PATH/bin/$1"
    curl $2 -sLo "$binfile" && chmod +x "$binfile"
}

function get_completion {
    local file="$SMILE_PATH/bash_completion/$1"
    curl $2 -sLo "$file"
}

install_dotfiles

hg_clone  ~/.hg_prompt           http://bitbucket.org/sjl/hg-prompt/

get_bin   hub                    http://defunkt.io/hub/standalone # http://defunkt.io/hub/
get_bin   ack                    http://beyondgrep.com/ack-2.04-single-file
get_bin   cloc                   http://kent.dl.sourceforge.net/project/cloc/cloc/v1.58/cloc-1.58.pl
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
# get_completion default           https://raw.github.com/revans/bash-it/master/completion/available/defaults.completion.bash
# get_completion brew              https://raw.github.com/revans/bash-it/master/completion/available/brew.completion.bash

# TODO How to handle gem / brew / etc. deps ?
# https://github.com/aanand/git-up


if [ -e "ruby" ]; then
    "*SMILE_PATH/vim/update_bundles.rb" --notrash
fi


echo "export SMILE=$SMILE_PATH" > ~/.smile.conf

