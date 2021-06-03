# my config :)

# prompt
autoload -Uz colors && colors
PROMPT='%B%F{gray}[%F{green}%n %F{gray}%~%F{gray}]%f$%b '
RPROMPT='%*'
export EDITOR=vim

# history
HISTFILE=~/.cache/zsh/history
HISTSIZE=100
SAVEHIST=100

# vi mode
bindkey -v
export KEYTIMEOUT=1

# autocomplete
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # include hidden files too

# vim keys in tab completion menu
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -v '^?' backward-delete-char

# other stuff
# TODO

# aliases and shortcuts
# alias vim=nvim
alias ls="ls --group-directories-first"
alias ll="ls -l"
alias la="ls -la"
alias update="sudo pacman -Syu"

# highlighting
eval "$(dircolors)"
alias ls='ls --color'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

