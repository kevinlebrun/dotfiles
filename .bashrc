export BASH_SILENCE_DEPRECATION_WARNING=1

[ -z "$PS1" ] && return

DOTFILES="$HOME/dotfiles"

export PATH=$DOTFILES/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

source "$DOTFILES/shell/env"

shopt -s cdspell
shopt -s dotglob extglob nocaseglob
shopt -s checkwinsize
shopt -s histappend cmdhist

CDPATH=.:~
HISTSIZE=10000
HISTCONTROL=ignoreboth
HISTIGNORE="ls:[bf]g:history:exit:reset:clear:cd *"
HISTTIMEFORMAT="%F %T "
unset HISTFILESIZE
export PROMPT_COMMAND='history -a'

[[ -z "$TMUX" ]] && export TERM=xterm-256color

if ! shopt -oq posix; then
    if which brew > /dev/null 2>&1 && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
        . "$(brew --prefix)/etc/bash_completion"
    elif [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi

    if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
        complete -o default -o nospace -F _git g
    fi

    [ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh
fi

source "$DOTFILES/shell/aliases"
source "$DOTFILES/shell/functions"

RESET_COLOR=$(tput sgr 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
MAGENTA=$(tput setaf 5)

export PROMPT_COMMAND="export RETURN_STATUS=\$?; $PROMPT_COMMAND"

source ~/.git-prompt.sh
PS1="\\n\[$MAGENTA\]\u\[$RESET_COLOR\] at \[$YELLOW\]\$(box_name)\[$RESET_COLOR\] in \[$GREEN\]\W\[$RESET_COLOR\]\$(__git_ps1 \" (%s)\")\\n\[\$([ \$RETURN_STATUS != 0 ] && echo \$RED)\]\$([ \$RETURN_STATUS != 0 ] && echo \"\$RETURN_STATUS \")\[$RESET_COLOR\]\$(prompt_char) "

[ -f "$DOTFILES/shell/local" ] && source "$DOTFILES/shell/local"
[ -f "$HOME/.shellrc_local" ] && source "$HOME/.shellrc_local"
