export SMILE=~/.smile

. $SMILE/bash/config
. $SMILE/bash/aliases

for i in $SMILE/completion/*; do
    . $i
done

if [ -e ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi
