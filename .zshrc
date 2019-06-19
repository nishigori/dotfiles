# My zshrc
#
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:$PATH
export TERM="xterm-256color"
export XDG_CONFIG_HOME=$HOME/.config


alias cl='clear'
alias k='kubectl'
alias mk='minikube'
alias tailf='tail -f'
alias vimless='vim -R'
alias vless='vim -R'
alias -g g='git'
alias -g p='git add -p'
alias mm='git master && git souji'
alias master='git master && git souji'
alias st='git status'
alias co='git checkout'
alias cob='git checkout -b'
alias fv='git fetch --verbose --prune'
alias pv='git pull --verbose'
alias ci='git commit'
alias di='git diff --ignore-space-change'
alias dic='git diff --cached --ignore-space-change'
alias dis='git diff --stat'

# ls using https://github.com/Peltoche/lsd
if which lsd >/dev/null 2>&1; then
    alias ls='lsd --group-dirs=first'
    alias  l='lsd --group-dirs=first -l'
    alias ll='lsd --group-dirs=first -l'
    alias la='lsd --group-dirs=first -la'
    alias al='lsd --group-dirs=first -la'
else
    alias ls="ls -G"
    alias  l='ls -l'
    alias ll='ls -l'
    alias la='ls -al'
fi

alias -s py=python
alias -s rb=ruby
alias -s mk=make

setopt auto_cd
setopt auto_pushd
setopt no_beep
setopt interactive_comments


#######
# zplug
#######
## Ref: https://github.com/b4b4r07/zplug
#source ~/.zplug/init.zsh
#
#zplug "zsh-users/zsh-syntax-highlighting"
#
#zplug "mollifier/anyframe"
#
#zplug "plugins/git", from:oh-my-zsh
## TODO: why warning?
##zplug 'git/git', use:'contrib/completion'
#zplug "plugins/python", from:oh-my-zsh
#zplug 'zsh-users/zsh-completions'
#zplug 'zsh-users/zsh-syntax-highlighting', defer:2
#zplug 'docker/compose', use:'contrib/completion/zsh'
#zplug 'moby/moby', use:'contrib/completion/zsh'
#zplug 'peterhurford/git-it-on.zsh'
## NOTE: If you want apply theme, write on $ZPLUG_HOME/init.zsh
#zplug "plugins/themes", from:oh-my-zsh
#
#case ${OSTYPE} in
#    darwin*)
#        zplug "plugins/osx", from:oh-my-zsh
#        zplug "plugins/brew", from:oh-my-zsh
#        zplug "plugins/brew-cask", from:oh-my-zsh
#        zplug "plugins/tmux", from:oh-my-zsh
#        ;;
#    freebsd*)
#        ;;
#    linux*)
#        zplug "plugins/gnu-utils", from:oh-my-zsh
#        if [ -f /etc/redhat-release ]; then
#            zplug "plugins/yum", from:oh-my-zsh
#        elif [ -f /etc/debian_version ]; then
#            zplug "plugins/debian", from:oh-my-zsh
#        fi
#        ;;
#esac
#
#source ~/.zplugrc.local
#
## Checking not-installing list
#if ! zplug check --verbose; then
#    printf "Install? [y/N]: "
#    if read -q; then
#        echo; zplug install
#    fi
#fi
#
#zplug load --verbose


#############
# Completions
#############
setopt complete_in_word      # カーソル位置で補完する。
#setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt glob_complete         # globを展開しないで候補の一覧から補完する。
setopt magic_equal_subst     # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt globdots              # 明確なドットの指定なしで.から始まるファイルをマッチ

zstyle ':completion:*' completer _complete
# Select complations list like emacs
zstyle ':completion:*:default' menu select=1
#zstyle ':completion:*:default' menu select=2
# Coloring for completion candidates
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' keep-prefix
zstyle ':completion:*' recent-dirs-insert both

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
# 補完関数の表示を過剰にする編
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format $YELLOW'%d'$DEFAULT
#zstyle ':completion:*:warnings' format $RED'No matches for:'$YELLOW' %d'$DEFAULT
#zstyle ':completion:*:descriptions' format $YELLOW'completing %B%d%b'$DEFAULT
#zstyle ':completion:*:corrections' format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'

autoload -Uz compinit
compinit


###########
# WordChars
###########
WORDCHARS='*?_.[]~&;!#$%^(){}<>'

autoload -Uz select-word-style
select-word-style default


#########
# History
#########
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000
HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '
setopt share_history 
setopt share_history
setopt inc_append_history
setopt hist_reduce_blanks
setopt hist_ignore_dups
setopt hist_no_store
setopt EXTENDED_HISTORY

peco-select-history() {
    BUFFER=$(history 1 | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\*?\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$LBUFFER")
    CURSOR=${#BUFFER}
    zle reset-prompt
}
zle -N peco-select-history

bindkey '^R' peco-select-history


#####
# Git
#####
bindkey '^G' peco-select-git-branch

peco-select-git-branch() {
  git branch -a --sort=-authordate |
    grep -v -e '->' -e '*' |
    perl -pe 's/^\h+//g' |
    perl -pe 's#^remotes/origin/###' |
    perl -nle 'print if !$c{$_}++' |
    peco |
    xargs git checkout
}
zle -N peco-select-git-branch


####
# Go
####
export GOPATH=$HOME
export PATH=$GOPATH/bin:$PATH
if which goenv >/dev/null; then
    if which go > /dev/null; then
        export GOROOT=$( go env GOROOT )
    fi
fi

bindkey '^O' peco-src

function peco-src () {
    local selected_dir=$(ghq list | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        selected_dir="$HOME/src/$selected_dir"
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src


########
# Python
########
export VIRTUALENVWRAPPER_PYTHON=$(which python)


########
# direnv
########
test "$(which direnv)" = "" || eval "$(direnv hook zsh)"


#######
# Ctags
#######
# like vimrc alpaca_tags settings
local ctags_default_opt='-R --exclude=".git*" --sort=yes'
alias ctags_go="${ctags_default_opt} --langdef=Go --langmap=Go:.go --regex-Go=/func([ \t]+\([^)]+\))?[ \t]+([a-zA-Z0-9_]+)/\2/d,func/ --regex-Go=/type[ \t]+([a-zA-Z_][a-zA-Z0-9_]+)/\1/d,type/"
alias ctags_py="${ctags_default_opt} --python-kinds=-i --exclude=\"*/build/*\""


############
# Subversion
############
export SVN_EDITOR=vim


############
# Apache Ant
############
export ANT_ARGS="-logger org.apache.tools.ant.listener.AnsiColorLogger"
export ANT_OPTS="$ANT_OPTS -Dant.logger.defaults=$HOME/.antrc_logger"


###########
# Travis CI
###########
if [ -f ~/.travis/travis.sh ]; then
    source ~/.travis/travis.sh
fi


############
# gcloud SDK
############
# The next line updates PATH for the Google Cloud SDK.
if [ -d ~/google-cloud-sdk ]; then
    source ~/google-cloud-sdk/path.zsh.inc
    source ~/google-cloud-sdk/completion.zsh.inc
    export PATH=$HOME/google-cloud-sdk/bin:$PATH
fi


##########
# Pygments
##########
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

#########
# Zplugin
#########
source $HOME/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk
zcompile $HOME/.zplugin/bin/zplugin.zsh 2>/dev/null

zplugin light zsh-users/zsh-autosuggestions
zplugin light zsh-users/zsh-syntax-highlighting
# https://qiita.com/mollifier/items/81b18c012d7841ab33c3
#zplugin light mollifier/anyframe

# https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins
zplugin snippet OMZ::lib/git.zsh
zplugin snippet OMZ::plugins/git/git.plugin.zsh

#zplugin snippet https://raw.githubusercontent.com/saltstack/salt/v2019.8/pkg/zsh_completion.zsh

case ${OSTYPE} in
    darwin*)
        #zplugin snippet OMZ::plugins/osx/osx.plugin.zsh
        zplugin snippet OMZ::plugins/brew/brew.plugin.zsh
        ;;
    freebsd*)
        ;;
    linux*)
        zplugin snippet OMZ::plugins/gnu-utils/gnu-utils.plugin.zsh
        ;;
esac

# [Theme]
zplugin ice from"gh"
zplugin load bhilburn/powerlevel9k
# https://github.com/bhilburn/powerlevel9k#available-prompt-segments
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_DISABLE_RPROMPT=false
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RBENV_PROMPT_ALWAYS_SHOW=false
POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW=false
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_VCS_SHOW_SUBMODULE_DIRTY=false
POWERLEVEL9K_VCS_HIDE_TAGS=true
POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes)
#POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind git-stash git-remotebranch git-tagname)
POWERLEVEL9K_VCS_HG_HOOKS=()
POWERLEVEL9K_VCS_SVN_HOOKS=()

POWERLEVEL9K_CUSTOM_WIFI_SIGNAL='echo @ $(git symbolic-ref --short HEAD 2>/dev/null)'
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_BACKGROUND="white"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_FOREGROUND="gray"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status time dir custom_wifi_signal)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(os_icon context)
#if [ -z "$ZSH_THEME" ]; then
#    zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure
#fi


##################
# Local dependency
##################
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi


##################
# End of execution
##################
autoload -U compinit
compinit

if [ "$DOTFILES/.zshrc.local" -nt "~/.zshrc.local.zwc" ]; then
    zcompile ~/.zshrc.local
fi
if [ "$DOTFILES/.zshrc" -nt "~/.zshrc.zwc" ]; then
    zcompile ~/.zshrc
fi
