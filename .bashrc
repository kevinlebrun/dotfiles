source $HOME/.smile.conf
source $SMILE/env

for i in $SMILE/bash/*; do source $i ; done
for i in $SMILE/functions/*; do source $i ; done
for i in $SMILE/aliases/*; do source $i ; done

if [[ -n "$PS1" ]] ; then
    shopt -s promptvars

    export PROMPT_COMMAND="export RETURN_STATUS=\$?; $PROMPT_COMMAND"

    function last_code {
        if [ "$RETURN_STATUS" != "0" ]; then echo $RETURN_STATUS' ' ; fi
    }

    function last_code_color {
        if [ "$RETURN_STATUS" != "0" ]; then echo $RED ; fi
    }

    function prompt_on {
        export PS1="\\n\[$MAGENTA\]\u\[$RESET_COLOR\] at \[$YELLOW\]\$(box_name)\[$RESET_COLOR\] in \[$GREEN\]\w\$(prompt_vcs)\\n\[\$(last_code_color)\]\$(last_code)\[$RESET_COLOR\]\$(prompt_char) "
    }

    function prompt_off {
        export PS1='\$ '
    }

    prompt_on
fi

# search in my $HOME directory as fallback
CDPATH=.:~

shopt -s cdspell

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

for i in $SMILE/completion/*; do source $i ; done

if [ -e $HOME/.bashrc_local ] ; then source $HOME/.bashrc_local ; fi

#/* vim: set ft=sh: */
