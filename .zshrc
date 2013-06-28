source $HOME/.smile.conf
source $SMILE/env

bindkey -e
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

setopt menucomplete

setopt -s glob_dots

autoload compinit
compinit

autoload -U colors
colors
setopt prompt_subst

for config_file ($SMILE/zsh/*.zsh) source $config_file
for aliases_file ($SMILE/aliases/*) source $aliases_file
for functions_file ($SMILE/functions/*) source $functions_file

autoload edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

local last_code="%(?,,%{$fg[red]%}[%?]%{$reset_color%})"

PROMPT='
%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}$(box_name)%{$reset_color%} in %{$fg[green]%}${PWD/#$HOME/~}%{$reset_color%}$(hg_prompt_info)$(git_prompt_info)
$(prompt_char) '

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# RPROMPT="%{$fg[white]%} $(~/.rvm/bin/rvm-prompt)$(~/.smile/bin/git-cwd-info)%{$reset_color%}"
local return_status="%{$fg[red]%}%(?.. ✘)%{$reset_color%}"
RPROMPT='${return_status}%{$reset_color%}'
#RPROMPT='%{$fg[white]%} $(~/.rvm/bin/rvm-prompt)%{$reset_color%}${return_status}%{$reset_color%}'

if [[ -s $HOME/.zshrc_local ]] ; then source $HOME/.zshrc_local ; fi
