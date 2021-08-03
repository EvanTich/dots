# my config :)

# color, prompt, and options
autoload -Uz colors && colors
PROMPT='%B%F{gray}[%F{green}%n %F{gray}%~%F{gray}]%f$%b '
RPROMPT='%*'
setopt auto_cd              # auto cd into directories
setopt interactive_comments # allows comments in shell
setopt inc_append_history   # appends to history (+instantly)
setopt hist_find_no_dups    # don't list multiple of the same command when using find
stty stop undef             # disable ctrl-s (terminal freeze)

# history
HISTFILE=~/.cache/zsh/history
HISTSIZE=10000
SAVEHIST=10000

# load shortcuts and aliases
source "$XDG_CONFIG_HOME/shell/shortcutrc"
source "$XDG_CONFIG_HOME/shell/aliasrc"

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

# other stuff?

# highlighting
eval "$(dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

