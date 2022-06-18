# check terminal type
case "$TERM" in
    (tramp | dumb | xterm-mono)
        PS1='$ '
        unset RPROMPT
        unset RPS1
        whence -w precmd >/dev/null && unfunction precmd
        whence -w preexec >/dev/null && unfunction preexec
        unsetopt zle
        unsetopt zle_bracketed_paste
        unsetopt prompt_cr
        unsetopt prompt_subst
        unsetopt rcs
        return
        ;;
esac

# init antigen
source "$HOME/antigen.zsh"

# access oh-my-zsh stuff
antigen use oh-my-zsh

# best theme
antigen theme kphoen

# oh-my-zsh plugins
antigen bundle git
antigen bundle extract
antigen bundle colored-man-pages

# extra github plugins
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle hlissner/zsh-autopair

antigen apply

# bindings
source "$HOME/.zsh_zle"

# misc
source "$HOME/.zsh_misc"
