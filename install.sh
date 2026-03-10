#!/usr/bin/env bash
set -e

DOTFILES_REPO="https://github.com/kevinlebrun/dotfiles.git"
DOTFILES="$HOME/dotfiles"

if [ -d "$DOTFILES" ]; then
    echo "Updating dotfiles..."
    git -C "$DOTFILES" pull --rebase
else
    echo "Cloning dotfiles..."
    git clone "$DOTFILES_REPO" "$DOTFILES"
fi

link() {
    src="$DOTFILES/$1"
    dest="$HOME/${2:-$1}"
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        echo "  backup $dest → ${dest}.bak"
        mv "$dest" "${dest}.bak"
    fi
    ln -sfn "$src" "$dest"
    echo "  $dest → $src"
}

echo "Linking dotfiles..."

# Shell
link .bashrc
link .bash_profile
link .zshrc
link .inputrc
link .ripgreprc

# Git
link .gitconfig
link .gitattributes
link .gitignore
link .git-prompt.sh

# Tools
link .editorconfig
link .curlrc
link .wgetrc
link .tmux.conf
link .hushlogin

# Vim
link .vimrc
link vim .vim

# Machine-specific local config
if [ ! -f "$HOME/.shellrc_local" ]; then
    echo "  note: create ~/.shellrc_local for machine-specific settings"
fi

echo "Done."
