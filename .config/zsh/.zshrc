# my config :)

# history
HISTFILE=~/.cache/zsh/history
HISTSIZE=10000
SAVEHIST=10000

# color, prompt, and options
autoload -Uz colors && colors
PROMPT='%B%F{gray}[%F{green}%n %F{gray}%~%F{gray}]%f$%b '
RPROMPT='%*'
setopt auto_cd              # auto cd into directories
setopt interactive_comments # allows comments in shell
setopt inc_append_history   # appends to history (+instantly)
setopt share_history        # shares history between shells
setopt hist_find_no_dups    # don't list multiple of the same command when using find
stty stop undef             # disable ctrl-s (terminal freeze)

# load shortcuts and aliases
source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

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

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

bindkey -s '^o' 'lfcd\n'
bindkey -s '^a' 'bc -lq\n'
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'
bindkey -s '^e' 'vim "$(fzf)"\n'

# other stuff?

# highlighting
eval "$(dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

