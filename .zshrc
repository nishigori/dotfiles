# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="cloud"
#
# My favorite themes 
# murilasso fox fino gallois re5et xiong-chiamiov-plus murilasso
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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
case "${OSTYPE}" in
    freebsd*|darwin*)
        plugins=( \
            osx brew \
            git github git-flow ssh-agent vagrant \
            python pip mercurial \
            symfony2 \
            ruby gem rails3 \
            )
        ;;
    linux*)
        if [ -f /etc/redhat-release ]; then
            plugins=( \
                yum \
                git git-flow ssh-agent \
                python mercurial \
                ruby gem \
                )
        else
            plugins=( \
                debian gnu-utils \
                git git-flow github ssh-agent \
                python pip mercurial \
                ruby gem \
                )
        fi
        ;;
esac

source $ZSH/oh-my-zsh.sh
eval "$(rbenv init -)"
