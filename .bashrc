export SMILE=~/.smile
. $SMILE/bash/env
. $SMILE/bash/config
. $SMILE/bash/aliases

if [ -e ~/.bashrc_local ]
then
    source ~/.bashrc_local
fi
