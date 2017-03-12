# My zshrc
#
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:$PATH

# Python
export VIRTUALENVWRAPPER_PYTHON=$(which python)

# Select complations list like emacs
zstyle ':completion:*:default' menu select=1

export TERM="xterm-256color"

# zplug: https://github.com/b4b4r07/zplug
source ~/.zplug/zplug

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"

zplug "mollifier/anyframe"

zplug "k4rthik/git-cal", as:command, frozen:1
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/python", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "tcnksm/docker-alias", of:zshrc, as:plugin

# NOTE: If you want apply theme, write on $ZPLUG_HOME/init.zsh
zplug "plugins/themes", from:oh-my-zsh

case ${OSTYPE} in
    darwin*)
        zplug "plugins/osx", from:oh-my-zsh
        zplug "plugins/brew", from:oh-my-zsh
        zplug "plugins/brew-cask", from:oh-my-zsh
        zplug "plugins/tmux", from:oh-my-zsh
        ;;
    freebsd*)
        ;;
    linux*)
        zplug "plugins/gnu-utils", from:oh-my-zsh
        if [ -f /etc/redhat-release ]; then
            zplug "plugins/yum", from:oh-my-zsh
        elif [ -f /etc/debian_version ]; then
            zplug "plugins/debian", from:oh-my-zsh
        fi
        ;;
esac

# Checking not-installing list
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose


alias ls="ls -G"
alias l='ls -l'
alias la='ls -al'
alias cl='clear'
alias tailf='tail -f'
alias vimless='vim -R'
alias vless='vim -R'
alias st='git status'
alias co='git checkout'
alias cob='git checkout -b'
alias fv='git fetch --verbose --prune'
alias pv='git pull --verbose'
alias ci='git commit'
alias di='git diff --ignore-space-change'
alias dic='git diff --cached --ignore-space-change'
alias dis='git diff --stat'

####
# Go
####
export GOPATH=$HOME
if which go > /dev/null; then
    export GOROOT=$( go env GOROOT )
fi
export PATH=$GOPATH/bin:$PATH


######
# peco
######
bindkey '^O' peco-src

function peco-src () {
    local selected_dir=$(ghq list | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        selected_dir="$GOPATH/src/$selected_dir"
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src

########
# direnv
########
eval "$(direnv hook zsh)"

#######
# Ctags
#######
# like vimrc alpaca_tags settings
local ctags_default_opt='-R --exclude=".git*" --sort=yes'
alias ctags_go="${ctags_default_opt} --langdef=Go --langmap=Go:.go --regex-Go=/func([ \t]+\([^)]+\))?[ \t]+([a-zA-Z0-9_]+)/\2/d,func/ --regex-Go=/type[ \t]+([a-zA-Z_][a-zA-Z0-9_]+)/\1/d,type/"
alias ctags_py="${ctags_default_opt} --python-kinds=-i --exclude=\"*/build/*\""

# History
HISTFILE=~/.zsh_history
SIZEHIST=100000
HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '
setopt hist_ignore_dups
setopt hist_no_store
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

# Subversion
export SVN_EDITOR=vim

# xconfig
export XDG_CONFIG_HOME=$HOME/.config

# Apache Ant
export ANT_ARGS="-logger org.apache.tools.ant.listener.AnsiColorLogger"
export ANT_OPTS="$ANT_OPTS -Dant.logger.defaults=$HOME/.antrc_logger"

# Travis CI
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -d ~/google-cloud-sdk ]; then
    source ~/google-cloud-sdk/path.zsh.inc
    source ~/google-cloud-sdk/completion.zsh.inc
fi

# Pygments
if type "pygmentize" > /dev/null; then
    #export LESS='-R'
    #export LESSOPEN='|~/bin/lessfilter %s'

    # unaliases 3rd-parties aliases
    type "c" > /dev/null && unalias c
    type "cl" > /dev/null && unalias cl

    alias c="pygmentize -O style=tango -f console256 -g"
    function cl() {
        pygmentize -O style=tango -f console256 -g $1 | nl -n ln -b a
    }
    alias cl=cl
fi

# Local dependency
test -f ~/.zshrc.local && source ~/.zshrc.local
