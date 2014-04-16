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
            autojump \
            vagrant knife knife_ssh \
            ant \
            git git-flow-avh ssh-agent \
            python pip mercurial virtualenv virtualenvwrapper fabric \
            ruby rbenv gem rake bundler \
            npm bower \
            composer symfony2 \
            scala \
            gradle \
            )
        ;;
    linux*)
        if [ -f /etc/redhat-release ]; then
            # https://gist.github.com/msabramo/2355834
            function git_prompt_info() {
                ref=$(git symbolic-ref HEAD 2> /dev/null) || return
                echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
            }

            plugins=( \
                yum gnu-utils \
                autojump \
                vagrant knife knife_ssh \
                ant \
                terminitor \
                git git-flow-avh ssh-agent \
                python pip mercurial virtualenv virtualenvwrapper fabric \
                ruby rbenv gem rake bundler \
                npm bower \
                composer symfony2 cake \
                )
        else
            # https://gist.github.com/msabramo/2355834
            function git_prompt_info() {
                ref=$(git symbolic-ref HEAD 2> /dev/null) || return
                echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
            }

            # autojump github mercurial npm
            plugins=( \
                gnu-utils \
                docker vagrant knife knife_ssh \
                ant \
                terminitor \
                git git-flow-avh ssh-agent \
                python pip virtualenv virtualenvwrapper fabric \
                ruby rbenv gem rake bundler \
                bower \
                composer symfony2 \
                )
        fi
        ;;
esac

source $ZSH/oh-my-zsh.sh
