export SMILE=~/.smile
export SMILE_BIN=$SMILE/bin
export SMILE_DOTFILES=$SMILE/dotfiles
. $SMILE_DOTFILES/bash/env
. $SMILE_DOTFILES/bash/config
. $SMILE_DOTFILES/bash/aliases

if [ -e ~/.bashrc_local ]
then
    source ~/.bashrc_local
fi
