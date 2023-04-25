# My zshrc
#

# DEBUG: https://stevenvanbael.com/profiling-zsh-startup
#zmodload zsh/zprof

export TERM="xterm-256color"
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export EDITOR=vi
export LESS="-XRF --shift 8 --LONG-PROMPT"
#
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
            $brew_root/opt/avr-gcc@11/bin(N-/)
            $brew_root/opt/avr-gcc@9/bin(N-/)
            $brew_root/opt/avr-gcc@8/bin(N-/)
            $brew_root/opt/gawk/libexec/gnubin(N-/)
            $brew_root/opt/berkeley-db@4/bin(N-/)
            $brew_root/opt/binutils/bin(N-/)
            $brew_root/opt/bison/bin(N-/)
            $brew_root/opt/bzip2/bin(N-/)
            $brew_root/opt/coreutils/libexec/gnubin(N-/)
            $brew_root/opt/curl/bin(N-/)
            $brew_root/opt/curl-openssl/bin(N-/)
            $brew_root/opt/findutils/libexec/gnubin(N-/)
            $brew_root/opt/gcc/bin(N-/)
            $brew_root/opt/gettext/bin(N-/)
            $brew_root/opt/git/share/git-core/contrib/diff-highlight(N-/)
            $brew_root/opt/gnu-sed/libexec/gnubin(N-/)
            $brew_root/opt/gnu-tar/libexec/gnubin(N-/)
            $brew_root/opt/gnu-time/libexec/gnubin(N-/)
            $brew_root/opt/gnu-which/libexec/gnubin(N-/)
            $brew_root/opt/go/bin(N-/)
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
            $brew_root/opt/openssl@3/bin(N-/)
            $brew_root/opt/qmk/bin/(N-/)
            $brew_root/opt/sqlite/bin(N-/)

            $path
        )

        fpath=(
            $brew_root/opt/git/share/zsh/site-functions(N-/)
            $fpath
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
alias mm='git master && git souji && git-delete-squashed-branches'
alias master='git master && git souji && git-delete-squashed-branches'
alias gg='git grep'
alias gl='git grep -l'
alias h='git hist origin/$(git default)^..@'
alias pu='git push -u origin $(git symbolic-ref --short HEAD)'
alias pf='git push --force-with-lease --force-if-includes'
alias pushu='git push -u origin $(git symbolic-ref --short HEAD)'
alias pushf='git push --force-with-lease --force-if-includes'
alias s='git status -sb'
alias st='git status'
alias co='git switch'
alias cob='git cob'
alias fv='git fv'
alias pv='git pv'
alias ci='git commit'
alias cim='git commit -m'
alias di='git --no-pager di'
alias dic='git --no-pager dic'
alias dis='git diff --stat'
alias dis='git diff --stat'
alias hist="git hist"
alias ec="editorconfig-checker" # for nvim-mason-null-ls
alias lazygit="lazygit --use-config-dir ~/.config/lazygit"

# ls using https://github.com/Peltoche/lsd
if (( $+commands[lsd] )); then
    alias ls='lsd'
    alias  l='lsd -l'
    alias ll='lsd -l'
    alias la='lsd -la'
    alias al='lsd -la'
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
case ${OSTYPE} in
    darwin*)
        # zinit installed by homebrew
        source $brew_root/opt/zinit/zinit.zsh
        ;;
    linux*)
        if [ ! -d ~/.zinit ]; then
            bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
        fi
        source $HOME/.zinit/bin/zinit.zsh
        ;;
esac

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice wait'0'
zinit light zsh-users/zsh-autosuggestions
zinit ice wait'0'
zinit light zsh-users/zsh-syntax-highlighting
# https://qiita.com/mollifier/items/81b18c012d7841ab33c3
#zinit light mollifier/anyframe
zinit ice wait'0' as'program' pick'bin/git-dsf'

case ${OSTYPE} in
    darwin*)
        ;;
    linux*)
        zinit snippet OMZ::plugins/gnu-utils/gnu-utils.plugin.zsh
        ;;
esac


# [Theme]
zinit ice deps=1
zinit load romkatv/powerlevel10k
# https://github.com/bhilburn/powerlevel9k#available-prompt-segments
POWERLEVEL10K_MODE='nerdfont-complete'
POWERLEVEL10K_DISABLE_RPROMPT=false
POWERLEVEL10K_PROMPT_ON_NEWLINE=true
POWERLEVEL10K_RBENV_PROMPT_ALWAYS_SHOW=false
POWERLEVEL10K_PYENV_PROMPT_ALWAYS_SHOW=false
POWERLEVEL10K_SHORTEN_DIR_LENGTH=3
POWERLEVEL10K_VCS_SHOW_SUBMODULE_DIRTY=false
POWERLEVEL10K_VCS_HIDE_TAGS=true
POWERLEVEL10K_VCS_GIT_HOOKS=(vcs-detect-changes)
#POWERLEVEL10K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind git-stash git-remotebranch git-tagname)
POWERLEVEL10K_VCS_HG_HOOKS=()
POWERLEVEL10K_VCS_SVN_HOOKS=()

POWERLEVEL10K_CUSTOM_WIFI_SIGNAL='echo @ $(git symbolic-ref --short HEAD 2>/dev/null)'
POWERLEVEL10K_CUSTOM_WIFI_SIGNAL_BACKGROUND="white"
POWERLEVEL10K_CUSTOM_WIFI_SIGNAL_FOREGROUND="gray"

POWERLEVEL10K_LEFT_PROMPT_ELEMENTS=(status time dir custom_wifi_signal)
POWERLEVEL10K_RIGHT_PROMPT_ELEMENTS=(os_icon context)


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
compinit -C


###########
# WordChars
###########
export WORDCHARS=' *?.[]~-=&;!#$%^(){}<>/|,'

autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars $WORDCHARS
zstyle ':zle:*' word-style unspecified


#########
# History
#########
HISTORY_IGNORE="(pwd|l[sal]|exit|mm|kill|pu)"
HISTFILE=$HOME/.zsh-history
HISTSIZE=25000
SAVEHIST=25000
HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '
setopt share_history
setopt inc_append_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_reduce_blanks
#setopt hist_no_store
setopt EXTENDED_HISTORY

incremental_search_history() {
  BUFFER=$(history -n -r 1 | fzf --exact --query="$LBUFFER" --prompt="History > ")
  CURSOR=${#BUFFER}
  #zle redisplay
}
zle -N incremental_search_history
bindkey "^R" incremental_search_history


###########
# Languages
###########
if (( $+commands[anyenv] )); then
    test -d $XDG_CONFIG_HOME/anyenv/anyenv-install || anyenv install --init

    if [[ ! -d ~/.anyenv/plugins/anyenv-update ]]; then
    	mkdir -p ~/.anyenv/plugins
    	git clone https://github.com/znz/anyenv-update.git ~/.anyenv/plugins/anyenv-update
    fi

    if [[ ! -f $XDG_CACHE_HOME/anyenv.cache ]]; then
    	anyenv init - zsh > $XDG_CACHE_HOME/anyenv.cache
	zcompile $XDG_CACHE_HOME/anyenv.cache
    fi
    source $XDG_CACHE_HOME/anyenv.cache
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

# rust
[ ! -f "$HOME/.cargo/env" ] || . "$HOME/.cargo/env"

#####
# Git
#####
if (( $+commands[gh] )); then eval "$(gh completion -s zsh)"; fi

bindkey '^O' move_ghq_directories
bindkey '^G' select-git-branch

move_ghq_directories() {
    selected=`ghq list | fzf --query "$LBUFFER"`
    if [ -n "${#selected}" ]; then
        target_dir="`ghq root`/$selected"
        echo "cd $target_dir"
        BUFFER="cd $target_dir"
        zle accept-line
    fi
    zle clear-screen
}
zle -N move_ghq_directories

select-git-branch() {
  git branch -a --sort=-authordate |
    grep -v -e '->' -e '*' |
    perl -pe 's/^\h+//g' |
    perl -pe 's#^remotes/origin/###' |
    perl -nle 'print if !$c{$_}++' |
    fzf |
    xargs git checkout
}
zle -N select-git-branch


##################
# Kubernates (k8s)
##################
# Currently I'm not using k8s
#if (( $+commands[kubectl] )); then
#    source <(kubectl completion zsh)
#    alias kc=kubectl
#fi


#####################
# CommandLine Tool(s)
#####################
export ANT_ARGS="-logger org.apache.tools.ant.listener.AnsiColorLogger"
export ANT_OPTS="$ANT_OPTS -Dant.logger.defaults=$HOME/.antrc_logger"
# https://github.com/junegunn/fzf#environment-variables
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"

if (( $+commands[direnv] )); then eval "$(direnv hook zsh)"; fi

# Powerful & Colorful command(s)
if (( $+commands[bat] )); then
    # https://github.com/sharkdp/bat
    alias c='bat'
    #export BAT_THEME=Dracula
    export BAT_THEME="Monokai Extended Light"
    export BAT_PAGER="less -XRF --shift 4 --LONG-PROMPT"
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# like vimrc alpaca_tags settings
local ctags_default_opt='-R --exclude=".git*" --sort=yes'
alias ctags_go="${ctags_default_opt} --langdef=Go --langmap=Go:.go --regex-Go=/func([ \t]+\([^)]+\))?[ \t]+([a-zA-Z0-9_]+)/\2/d,func/ --regex-Go=/type[ \t]+([a-zA-Z_][a-zA-Z0-9_]+)/\1/d,type/"
alias ctags_py="${ctags_default_opt} --python-kinds=-i --exclude=\"*/build/*\""


#####
# AWS
#####
if (( $+commands[copilot] )); then source <(copilot completion zsh); fi


############
# gcloud SDK
############
case ${OSTYPE} in
    darwin*)
        source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
        source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
        ;;
    linux*)
        ;;
esac

##################
# Local dependency
##################
if [ -f ~/.secrets/.zshrc.local ]; then
    source ~/.secrets/.zshrc.local
fi


##################
# End of execution
##################
if [ "$DOTFILES/.secrets/.zshrc.local" -nt "~/.secrets/.zshrc.local.zwc" ]; then
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# DEBUG: https://stevenvanbael.com/profiling-zsh-startup
#zprof
