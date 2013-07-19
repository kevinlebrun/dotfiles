source $HOME/.smile.conf

export PATH=$SMILE/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

export GREP_OPTIONS='--color=auto'

eval "$(dircolors -b ~/.dircolors)"

hash vim &>/dev/null && export EDITOR=vim

# disable annoying beep
[[ -x setterm ]] && setterm -bfreq 0

# disable flow control
stty -ixon

# search in my $HOME directory as fallback
CDPATH=.:~

shopt -s autocd
# shopt -s cdable_vars # TEST with numergy / home / smile / etc.
shopt -s cdspell
shopt -s dotglob extglob
# shopt -s nullglob # don't work very well with bash_completion
shopt -s checkjobs
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
if [ -d "$HOME/.rbenv" ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)";
fi

[[ -z "$TMUX" ]] && export TERM=xterm-256color

case "$TERM" in
    xterm*) export TERM=xterm-256color
esac

if ! shopt -oq posix; then
    if [ -f /usr/local/share/bash-completion/bash_completion ]; then
        . /usr/local/share/bash-completion/bash_completion
    elif [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

for file in $SMILE/bash_completion/!(.gitignore); do source "$file"; done

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
        export PS1="\\n\[$MAGENTA\]\u\[$RESET_COLOR\] at \[$YELLOW\]\$(box_name)\[$RESET_COLOR\] in \[$GREEN\]\w\[$RESET_COLOR\]\$(prompt_git || prompt_hg)\\n\[\$(last_code_color)\]\$(last_code)\[$RESET_COLOR\]\$(prompt_char) "
    }

    function prompt_off {
        export PS1='\$ '
    }

    prompt_on
fi

[ -e "$HOME/.bashrc_local" ] && source "$HOME/.bashrc_local"

#/* vim: set ft=sh: */
