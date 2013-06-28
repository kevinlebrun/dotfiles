## Command history configuration
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# I want to see dups to make stats
# setopt hist_ignore_dups
setopt share_history

setopt hist_verify
setopt inc_append_history
setopt extended_history
# setopt hist_expire_dups_first
setopt hist_ignore_space

setopt SHARE_HISTORY
setopt APPEND_HISTORY
