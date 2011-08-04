# users generic .zshrc file for zsh(1)

## Environment variable configuration
#
# LANG {{{
export LANG=ja_JP.UTF-8
case ${UID} in
    0)
        LANG=C
        ;;
esac
# }}}

## Default shell configuration {{{
#
# set prompt
autoload colors
colors
case ${UID} in
    0)
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') %B%{${fg[red]}%}%/#%{${reset_color}%}%b "
        PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
        SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
        ;;
    *)
        PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
        PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
        SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
        [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
        ;;
esac
# }}}

# auto change directory
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
setopt auto_pushd

# command correct edition before each completion attempt
setopt correct

# compacked complete list display
setopt list_packed

# no remove postfix slash of command line
setopt noautoremoveslash

# no beep sound when complete list displayed
setopt nolistbeep


## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a gets to line head and Ctrl-e gets {{{
#   to end) and something additions
#bindkey -e
#bindkey "^[[1~" beginning-of-line # Home gets to line head
#bindkey "^[[4~" end-of-line # End gets to line end
#bindkey "^[[3~" delete-char # Del
# }}}

# vi like keybind
bindkey -v
alias vi="vim"

## Set vi mode status bar {{{ 

#
# Reads until the given character has been entered.
#
readuntil () {
    typeset a
    while [ "$a" != "$1" ]
    do
        read -E -k 1 a
    done
}

#
# If the $SHOWMODE variable is set, displays the vi mode, specified by
# the $VIMODE variable, under the current command line.
# 
# Arguments:
#
#   1 (optional): Beyond normal calculations, the number of additional
#   lines to move down before printing the mode.  Defaults to zero.
#
showmode() {
    typeset movedown
    typeset row

    # Get number of lines down to print mode
    movedown=$(($(echo "$RBUFFER" | wc -l) + ${1:-0}))

    # Get current row position
    echo -n "\e[6n"
    row="${${$(readuntil R)#*\[}%;*}"

    # Are we at the bottom of the terminal?
    if [ $((row+movedown)) -gt "$LINES" ]
    then
        # Scroll terminal up one line
        echo -n "\e[1S"

        # Move cursor up one line
        echo -n "\e[1A"
    fi

    # Save cursor position
    echo -n "\e[s"

    # Move cursor to start of line $movedown lines down
    echo -n "\e[$movedown;E"

    # Change font attributes
    echo -n "\e[1m"

    # Has a mode been set?
    if [ -n "$VIMODE" ]
    then
        # Print mode line
        echo -n "-- $VIMODE -- "
    else
        # Clear mode line
        echo -n "\e[0K"
    fi

    # Restore font
    echo -n "\e[0m"

    # Restore cursor position
    echo -n "\e[u"
}

clearmode() {
    VIMODE= showmode
}

#
# Temporary function to extend built-in widgets to display mode.
#
#   1: The name of the widget.
#
#   2: The mode string.
#
#   3 (optional): Beyond normal calculations, the number of additional
#   lines to move down before printing the mode.  Defaults to zero.
#
makemodal () {
    # Create new function
    eval "$1() { zle .'$1'; ${2:+VIMODE='$2'}; showmode $3 }"

    # Create new widget
    zle -N "\n$1"
}

# Extend widgets
makemodal vi-add-eol           INSERT
makemodal vi-add-next          INSERT
makemodal vi-change            INSERT
makemodal vi-change-eol        INSERT
makemodal vi-change-whole-line INSERT
makemodal vi-insert            INSERT
makemodal vi-insert-bol        INSERT
makemodal vi-open-line-above   INSERT
makemodal vi-substitute        INSERT
makemodal vi-open-line-below   INSERT 1
makemodal vi-replace           REPLACE
makemodal vi-cmd-mode          NORMAL

unfunction makemodal
# }}}

# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# reverse menu completion binded to Shift-Tab
bindkey "\e[Z" reverse-menu-complete

## Command history configuration
HISTFILE=${HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

## Completion configuration
fpath=(${HOME}/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit

## zsh editor
autoload zed

## Prediction configuration
#
#autoload predict-on
#predict-off

## Alias configuration
#
# expand aliases before completing
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
    freebsd*|darwin*)
        alias ls="ls -G -w"
        ;;
    linux*)
        alias ls="ls --color"
        ;;
esac

alias la="ls -al"
alias lf="ls -F"
alias ll="ls -l"
alias l="ls -l"

alias untar='tar xvf'

alias du="du -h"
alias df="df -h"

alias su="su -l"

## terminal configuration
case "${TERM}" in
    screen)
        TERM=xterm
        ;;
esac

case "${TERM}" in
    xterm|xterm-color)
        export LSCOLORS=exfxcxdxbxegedabagacad
        export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
        ;;
    kterm-color)
        stty erase '^H'
        export LSCOLORS=exfxcxdxbxegedabagacad
        export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
        ;;
    kterm)
        stty erase '^H'
        ;;
    cons25)
        unset LANG
        export LSCOLORS=ExFxCxdxBxegedabagacad
        export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
        ;;
    jfbterm-color)
        export LSCOLORS=gxFxCxdxBxegedabagacad
        export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*' list-colors 'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
        ;;
esac

# set terminal title including current directory
case "${TERM}" in
    xterm|xterm-color|kterm|kterm-color)
        precmd() {
            echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
        }
        ;;
esac

## load user .zshrc configuration file
[ -f ${HOME}/.zshrc.mine ] && source ${HOME}/.zshrc.mine

# throw watchr's path
PATH='/var/lib/gems/1.8/bin:$PATH'


# vim:set foldmethod=marker expandtab ts=4 sw=4 sts=0:
