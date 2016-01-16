# My zshrc
#
export PATH=$HOME/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin:$PATH

# Python
export VIRTUALENVWRAPPER_PYTHON=$(which python)

# Select complations list like emacs
zstyle ':completion:*:default' menu select=1

export TERM="xterm-256color"

# zplug: https://github.com/b4b4r07/zplug
export ZPLUG_HOME=${0:a:h}/.zsh/zplug
source $ZPLUG_HOME/zplug

# check コマンドで未インストール項目があるかどうか verbose にチェックし
# false のとき（つまり未インストール項目がある）y/N プロンプトで
# インストールする
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# プラグインを読み込み、コマンドにパスを通す
zplug load --verbose


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
