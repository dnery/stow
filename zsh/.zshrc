# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use vi keybindings even if our EDITOR is set to emacs
bindkey -v

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=10000
HISTFILE=${ZDOTDIR}/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Allow completion of privileged envs
zstyle ':completion::complete:*' gain-privileges 1

# Set 'rehash' to happen automatically
zstyle ':completion:*' rehash true


# Set up history search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# We need a zkbd compatible hash (man 5 terminfo) - this
# allows us to refer to keycodes without losing our minds
typeset -g -A key
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
[[ -n "${key[Up]}" ]] && bindkey -- "${key[Up]}"	up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}"	down-line-or-beginning-search

# Ensure terminal is in application when zle is
# active, only then are the values from $terminfo valid
if (()); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi


# Alias git to 'g' with auto-complete
fpath=(${ZDOTDIR}/fpath $fpath)
# __git_complete_command g __git_zsh_main
alias g='git'

# "File manager" like key binds
cdUndoKey() {
	popd
	zle		reset-prompt
	print
	ls
	zle		reset-prompt
}
cdParentKey() {
	pushd		..
	zle		reset-prompt
	print
	ls
	zle		reset-prompt
}
zle -N			cdParentKey
zle -N			cdUndoKey
bindkey '^[[1;3A'	cdParentKey
bindkey '^[[1;3D'	cdUndoKey

# Source shell commons (make sure this is done last)
source ${XDG_CONFIG_HOME}/.shell.common
