# My zshrc
#
export TERM="xterm-256color"
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=vi

path=(
    $HOME/bin(N-/)
    $HOME/.anyenv/bin(N-/)
    $HOME/.composer/vendor/bin(N-/)
    $path
)

case ${OSTYPE} in
    darwin*)
        if [[ "arm64" == "$(uname -m)" ]]; then
            brew_root=/opt/homebrew
        else
            brew_root=/usr/local
        fi

        manpath=(
            $brew_root/opt/coreutils/libexec/gnuman(N-/)
            $brew_root/opt/findutils/libexec/gnuman(N-/)
            $brew_root/opt/gnu-sed/libexec/gnuman(N-/)
            $brew_root/opt/gnu-tar/libexec/gnuman(N-/)
            $brew_root/opt/gnu-time/libexec/gnuman(N-/)
            $brew_root/opt/gnu-which/libexec/gnuman(N-/)
            $brew_root/opt/grep/libexec/gnuman(N-/)
            $manpath
        )

        path=(
            $brew_root/bin(N-/)
            $brew_root/sbin(N-/)
            $brew_root/opt/apr/bin(N-/)
            $brew_root/opt/binutils/bin(N-/)
            $brew_root/opt/bison/bin(N-/)
            $brew_root/opt/bzip2/bin(N-/)
            $brew_root/opt/coreutils/libexec/gnubin(N-/)
            $brew_root/opt/curl/bin(N-/)
            $brew_root/opt/curl-openssl/bin(N-/)
            $brew_root/opt/findutils/libexec/gnubin(N-/)
            $brew_root/opt/gcc/bin(N-/)
            $brew_root/opt/gettext/bin(N-/)
            $brew_root/opt/gnu-sed/libexec/gnubin(N-/)
            $brew_root/opt/gnu-tar/libexec/gnubin(N-/)
            $brew_root/opt/gnu-time/libexec/gnubin(N-/)
            $brew_root/opt/gnu-which/libexec/gnubin(N-/)
            $brew_root/opt/grep/libexec/gnubin(N-/)
            $brew_root/opt/icu4c/bin(N-/)
            $brew_root/opt/icu4c/sbin(N-/)
            $brew_root/opt/libarchive/bin(N-/)
            $brew_root/opt/libpq/bin(N-/)
            $brew_root/opt/libressl/bin(N-/)
            $brew_root/opt/libxml2/bin(N-/)
            $brew_root/opt/libxslt/bin(N-/)
            $brew_root/opt/llvm/bin(N-/)
            $brew_root/opt/ncurses/bin(N-/)
            $brew_root/opt/make/libexec/gnubin(N-/)
            $brew_root/opt/mysql-client/bin(N-/)
            $brew_root/opt/openjdk/bin(N-/)
            $brew_root/opt/openldap/bin(N-/)
            $brew_root/opt/openldap/sbin(N-/)
            $brew_root/opt/sqlite/bin(N-/)

            $path
        )

        # local version specify even if
        #Z_PROTOBUF_VER=${Z_PROTOBUF_VER:-3.13.0_1}
        #path=( /usr/local/opt/protobuf@$Z_PROTOBUF_VER/bin $path )
        #export LDFLAGS="-L/usr/local/opt/protobuf@$Z_PROTOBUF_VER/lib"
        #export CPPFLAGS="-I/usr/local/opt/protobuf@$Z_PROTOBUF_VER/include"
        #export PKG_CONFIG_PATH="/usr/local/opt/protobuf@$Z_PROTOBUF_VER/lib/pkgconfig"

        export HOMEBREW_NO_AUTO_UPDATE=1
        export CURL_CONFIG=$brew_root/opt/curl/bin/curl-config(N-/)
        export GROOVY_HOME=$brew_root/opt/groovy/libexec(N-/)
        ;;
esac

alias k='kubectl'
alias tailf='tail -f'
alias -g g='git'
alias -g p='git add -p'
alias mm='git master && git souji'
alias master='git master && git souji'
alias s='git status -sb'
alias st='git status'
alias co='git checkout'
alias cob='git checkout -b'
alias fv='git fetch --verbose --prune'
alias pv='git pull --verbose'
alias ci='git commit'
alias cim='git commit -m'
alias di='git diff --ignore-space-change'
alias dic='git diff --cached --ignore-space-change'
alias dis='git diff --stat'
alias dis='git diff --stat'
alias hist="log --graph --pretty='format:%C(green)%h%C(black blue)%d%Creset %s %C(cyan)%ci%Creset %C(magenta ul)By %cn%Creset'"

# ls using https://github.com/Peltoche/lsd
if (( $+commands[lsd] )); then
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

setopt auto_cd
setopt auto_pushd
setopt no_beep
setopt interactive_comments


#######
# zinit
#######
if [ ! -d ~/.zinit ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
fi
source $HOME/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of zinit's installer chunk
zcompile $HOME/.zinit/bin/zinit.zsh 2>/dev/null

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
# https://qiita.com/mollifier/items/81b18c012d7841ab33c3
#zinit light mollifier/anyframe

# https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins
zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh

#zinit snippet https://raw.githubusercontent.com/saltstack/salt/v2019.8/pkg/zsh_completion.zsh

case ${OSTYPE} in
    darwin*)
        #zinit snippet OMZ::plugins/osx/osx.plugin.zsh
        ;;
    freebsd*)
        ;;
    linux*)
        zinit snippet OMZ::plugins/gnu-utils/gnu-utils.plugin.zsh
        ;;
esac

# [Theme]
zinit ice from"gh"
zinit load bhilburn/powerlevel9k
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
#    zinit ice pick"async.zsh" src"pure.zsh"; zinit light sindresorhus/pure
#fi


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


###########
# Languages
###########
if (( $+commands[anyenv] )); then
    test -d .config/anyenv/anyenv-install || anyenv install --init
    eval "$(anyenv init - zsh)"

    mkdir -p ~/.anyenv/plugins
    test -d ~/.anyenv/plugins/anyenv-update || git clone https://github.com/znz/anyenv-update.git ~/.anyenv/plugins/anyenv-update
fi

export GOPATH=$HOME
path=( $GOPATH/bin(N-/) $path)

if (( $+commands[go] )); then
    export GOROOT=$(go env GOROOT);
    path=($(go env GOPATH)/bin(N-/) $path)
fi

# phpenv loading is very slow. use brew php@x.x and declare PATH via direnv
#if (( $+commands[phpenv] )); then ...; fi

if (( $+commands[plenv] )); then
    eval "$(plenv init - zsh)"
    export PERL_MB_OPT="--install_base \"~/perl5\""
    export PERL_MM_OPT="INSTALL_BASE=~/perl5"
fi


#####
# Git
#####
bindkey '^G' peco-select-git-branch
bindkey "^X^P" peco-checkout-pull-request

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

function peco-checkout-pull-request () {
    local selected_pr_id=$(gh pr list | peco | awk '{ print $1 }')
    if [ -n "$selected_pr_id" ]; then
        BUFFER="gh pr checkout ${selected_pr_id}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-checkout-pull-request


##################
# Kubernates (k8s)
##################
if (( $+commands[kubectl] )); then
    source <(kubectl completion zsh)
    alias kc=kubectl
fi

# https://qiita.com/sonots/items/f82912367693d717ff06
function gke-activate() {
  name="$1"
  zone_or_region="$2"
  if echo "${zone_or_region}" | grep '[^-]*-[^-]*-[^-]*' > /dev/null; then
    echo "gcloud container clusters get-credentials \"${name}\" --zone=\"${zone_or_region}\""
    gcloud container clusters get-credentials "${name}" --zone="${zone_or_region}"
  else
    echo "gcloud container clusters get-credentials \"${name}\" --region=\"${zone_or_region}\""
    gcloud container clusters get-credentials "${name}" --region="${zone_or_region}"
  fi
}
#function kx-complete() {
#  _values $(gcloud container clusters list | awk '{print $1}')
#}
#function kx() {
#  name="$1"
#  if [ -z "$name" ]; then
#    line=$(gcloud container clusters list | peco)
#    name=$(echo $line | awk '{print $1}')
#  else
#    line=$(gcloud container clusters list | grep "$name")
#  fi
#  zone_or_region=$(echo $line | awk '{print $2}')
#  gke-activate "${name}" "${zone_or_region}"
#}
#compdef kx-complete kx


#####################
# CommandLine Tool(s)
#####################
export ANT_ARGS="-logger org.apache.tools.ant.listener.AnsiColorLogger"
export ANT_OPTS="$ANT_OPTS -Dant.logger.defaults=$HOME/.antrc_logger"

# Powerful & Colorful command(s)
if (( $+commands[bat] )); then
    alias c='bat'
    export BAT_THEME=Dracula
fi

# like vimrc alpaca_tags settings
local ctags_default_opt='-R --exclude=".git*" --sort=yes'
alias ctags_go="${ctags_default_opt} --langdef=Go --langmap=Go:.go --regex-Go=/func([ \t]+\([^)]+\))?[ \t]+([a-zA-Z0-9_]+)/\2/d,func/ --regex-Go=/type[ \t]+([a-zA-Z_][a-zA-Z0-9_]+)/\1/d,type/"
alias ctags_py="${ctags_default_opt} --python-kinds=-i --exclude=\"*/build/*\""

if (( $+commands[direnv] )); then eval "$(direnv hook zsh)"; fi
if (( $+commands[gh] ));     then eval "$(gh completion -s zsh)"; fi

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


#####
# AWS
#####
if (( $+commands[copilot] )); then source <(copilot completion zsh); fi


############
# gcloud SDK
############
if [ -d /opt/homebrew/Caskroom/google-cloud-sdk ]; then
    source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
    source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
elif [ -d /usr/local/Caskroom/google-cloud-sdk ]; then
    source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
    source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
elif [ -d ~/google-cloud-sdk ]; then
    source ~/google-cloud-sdk/path.zsh.inc
    source ~/google-cloud-sdk/completion.zsh.inc
    path=( $HOME/google-cloud-sdk/bin(N-/) $path )
fi


##################
# Local dependency
##################
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi


##################
# End of execution
##################
if [ "$DOTFILES/.zshrc.local" -nt "~/.zshrc.local.zwc" ]; then
    zcompile ~/.zshrc.local
fi
if [ "$DOTFILES/.zshrc" -nt "~/.zshrc.zwc" ]; then
    zcompile ~/.zshrc
fi

typeset -T LD_LIBRARY_PATH ld_library_path
typeset -U ld_library_path
typeset -T LIBRARY_PATH library_path
typeset -U library_path
typeset -U path PATH
