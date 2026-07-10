DOTFILES="$HOME/dotfiles"

export PATH=$DOTFILES/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

source "$DOTFILES/shell/env"

setopt AUTO_CD CORRECT
setopt GLOB_DOTS EXTENDED_GLOB NO_CASE_GLOB
setopt NO_BEEP

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HISTORY_IGNORE="(ls|bg|fg|history|exit|reset|clear|cd *)"
setopt APPEND_HISTORY INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS

cdpath=(. ~)

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[5C' forward-word
bindkey '^[[5D' backward-word

source "$DOTFILES/shell/aliases"
source "$DOTFILES/shell/functions"

autoload -Uz vcs_info
precmd() { vcs_info }
setopt PROMPT_SUBST
zstyle ':vcs_info:git:*' formats ' (%b)'

PROMPT='
%F{magenta}%n%f at %F{yellow}$(box_name)%f in %F{green}%1~%f${vcs_info_msg_0_}
%(?.%F{default}.%F{red}%?%f )%(!.#.○) '

[ -f "$HOME/.shellrc_local" ] && source "$HOME/.shellrc_local"

eval "$(dd-gitsign load-key)"

# BEGIN SCFW MANAGED BLOCK
alias npm="scfw run npm"
alias pip="scfw run pip"
alias poetry="scfw run poetry"
export SCFW_DD_AGENT_LOG_PORT="10365"
export SCFW_DD_LOG_LEVEL="ALLOW"
export SCFW_HOME="/Users/kevin.lebrun/.scfw"
# END SCFW MANAGED BLOCK

# Trajectory - AI coding agent observability
export PATH="/Users/kevin.lebrun/.trajectory/bin:$PATH"
