# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="cloud"
source $HOME/.zshrc.local

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Select complations list like emacs
zstyle ':completion:*:default' menu select=1

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
case "${OSTYPE}" in
    freebsd*|darwin*)
        # Mac OS X
        plugins=( \
            osx brew \
            ant \
            git github git-flow ssh-agent vagrant \
            python pip mercurial \
            ruby rbenv gem bundler \
            symfony2 \
            )
        ;;
    linux*)
        if [ -f /etc/redhat-release ]; then
            plugins=( \
                yum \
                ant \
                git git-flow ssh-agent \
                python mercurial \
                ruby rbenv gem bundler \
                symfony2 \
                )
        else
            plugins=( \
                debian gnu-utils \
                ant \
                git git-flow github ssh-agent \
                python pip mercurial \
                ruby gem bundler \
                symfony2 \
                )
        fi
        ;;
esac

source $ZSH/oh-my-zsh.sh
eval "$(rbenv init -)"
