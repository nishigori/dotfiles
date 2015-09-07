# My zshrc
#
export PATH=$HOME/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin:$PATH

# Python
export VIRTUALENVWRAPPER_PYTHON=$(which python)

# Select complations list like emacs
zstyle ':completion:*:default' menu select=1

[ -d ~/.zsh/zgen ] || git clone https://github.com/tarjoilija/zgen.git ~/.zsh/zgen
source $HOME/.zsh/zgen/zgen.zsh

# check if there's no init script
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen load zsh-users/zsh-completions src
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load kennethreitz/autoenv
    zgen load Tarrasch/zsh-bd

    ## oh-my-zsh
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/autojump
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/command-not-found
    zgen oh-my-zsh plugins/colored-man

    # bulk load
    zgen loadall <<EOPLUGINS
        zsh-users/zsh-history-substring-search
EOPLUGINS
    # ^ can't indent this EOPLUGINS

    if [ -f ~/.zsh/zgenrc_local ]; then
        source ~/.zsh/zgenrc_local
    else
        zgen oh-my-zsh themes/bira
    fi

    # save all to init script
    zgen save
fi

alias ls="ls -G"
alias l='ls -l'
alias la='ls -al'
alias cl='clear'
alias tailf='tail -f'
alias vimless='vim -R'
alias vless='vim -R'

# Ctags
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

# Apache Ant
export ANT_ARGS="-logger org.apache.tools.ant.listener.AnsiColorLogger"
export ANT_OPTS="$ANT_OPTS -Dant.logger.defaults=$HOME/.antrc_logger"

# sshpass
# brew install https://raw.github.com/eugeneoden/homebrew/eca9de1/Library/Formula/sshpass.rb
alias issh="sshpass -f ~/.ssh/pass ssh -o StrictHostKeyChecking=no "

# Travis CI
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -d ~/google-cloud-sdk ]; then
    source ~/google-cloud-sdk/path.zsh.inc
    source ~/google-cloud-sdk/completion.zsh.inc
fi

# Pygments
if type "pygmentize" > /dev/null; then
    export LESS='-R'
    export LESSOPEN='|~/bin/lessfilter %s'

    # unaliases 3rd-parties aliases
    type "c" > /dev/null && unalias c
    type "cl" > /dev/null && unalias cl

    alias c="pygmentize -O style=monokai -f console256 -g"
    function cl() {
        pygmentize -O style=monokai -f console256 -g $1 | nl -n ln -b a
    }
    alias cl=cl
fi

# Local dependency
test -f ~/.zshrc.local && source ~/.zshrc.local
