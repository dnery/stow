export $(envsubst < ../.env)

# The following lines were added by compinstall
zstyle :compinstall filename '/home/danilo/.config/zsh/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=1000
SAVEHIST=10000
setopt extendedglob notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

# My configs
prompt walters

# Customize path
typeset -U path PATH
path=($HOME/.local/bin $path)
export PATH
