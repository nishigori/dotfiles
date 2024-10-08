# My zshrc
#
# vim: set ts=2 sw=2 sts=0 expandtab:

# DEBUG: https://stevenvanbael.com/profiling-zsh-startup
#zmodload zsh/zprof

export TERM="xterm-256color"
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export EDITOR=vi
export LESS="-XRF --shift 8 --LONG-PROMPT"

path=( $HOME/.local/bin(N-/) $HOME/bin(N-/)  $path )

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

    fpath=( $brew_root/share/zsh/site-functions(N-/) $fpath )

    export HOMEBREW_NO_AUTO_UPDATE=1
    export CURL_CONFIG=$brew_root/opt/curl/bin/curl-config(N-/)
    export GROOVY_HOME=$brew_root/opt/groovy/libexec(N-/)
    ;;
esac

# Dark / Light
local system_appearance=${$(defaults read -g AppleInterfaceStyle 2>/dev/null):-Light}

bindkey -e
alias k='kubectl'
alias -g g='git'
alias -g p='git add -p'
alias mm='git master && git souji && git-delete-squashed-branches'
alias master='git master && git souji && git-delete-squashed-branches'
alias lg='lazygit'
alias gg='git grep'
alias gl='git grep -l'
alias git-tree='git tree | tree --fromfile | bat -p'
alias gt='gtree'
alias h='git hist origin/$(git default)^..@'
alias hn='git hist --name-only origin/$(git default)^..@'
alias pu='git push -u origin $(git branch --show-current)'
alias pf='git push --force-with-lease --force-if-includes'
alias pushu='git push -u origin $(git symbolic-ref --short HEAD)'
alias pushf='git push --force-with-lease --force-if-includes'
alias br='git br'
alias bra='git bra'
alias ci='git commit'
alias cim='git commit -m'
alias co='git switch'
alias cob='git cob'
alias di='git --no-pager di'
alias dic='git --no-pager dic'
alias fv='git fv'
alias hist="git hist"
alias pv='git pv'
alias s='git status -sb'
alias st='git status'
alias ec="editorconfig-checker" # for nvim-mason-null-ls
alias lazygit="lazygit --use-config-dir ~/.config/lazygit"

function i() { # install-for-current-dir
  if [ -f "$PWD/.tool-versions" ]; then (set -x; mise install -y); fi
  if [ -f "$PWD/.lefthook.yml" ]; then (set -x; lefthook install); fi
  if [ -f "$PWD/rust-toolchain.toml" ]; then (set -x; rustup update); fi
  if [ -f "$PWD/bun.lockb" ]; then
    (set -x; bun install)
  elif [ -f "$PWD/package-lock.json" ]; then
    (set -x; npm ci)
  fi
}

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

zinit wait lucid atload'_zsh_autosuggest_start' light-mode for zsh-users/zsh-autosuggestions
zinit ice wait
zinit light zsh-users/zsh-syntax-highlighting
# https://qiita.com/mollifier/items/81b18c012d7841ab33c3
#zinit light mollifier/anyframe
zinit ice wait as'program' pick'bin/git-dsf'

case ${OSTYPE} in
  darwin*)
    ;;
  linux*)
    zinit snippet OMZ::plugins/gnu-utils/gnu-utils.plugin.zsh
    ;;
esac


# [Theme]
# https://github.com/zdharma-continuum/zinit#plugins-and-snippets
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship


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

function fzf-select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history

function fzf-cdr() {
  local selected_dir=$(cdr -l | awk '{ print $2 }' | fzf)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-cdr
setopt noflowcontrol
bindkey '^q' fzf-cdr

#####################
# CommandLine Tool(s)
#####################
# https://github.com/junegunn/fzf#environment-variables
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"

if (( $+commands[direnv] )); then eval "$(direnv hook zsh)"; fi

if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
  alias asdf=mise
  alias mx="mise x --"
fi

# history enhancement
if (( $+commands[atuin] )); then
  export ATUIN_NOBIND="true"
  eval "$(atuin init zsh)"

  bindkey '^R' atuin-search
  bindkey "^[[A" atuin-up-search
  #bindkey "^[OA" atuin-up-search
fi

# bat (Powerful & Colorful commands)
if (( $+commands[bat] )); then
  # https://github.com/sharkdp/bat
  alias c='bat'
  export BAT_THEME="Monokai Extended ${system_appearance}"
  export BAT_PAGER="less -XRF --shift 4 --LONG-PROMPT"
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# lsd (next gen ls command)
if [ -d $XDG_CONFIG_HOME/lsd ]; then
  (cd $XDG_CONFIG_HOME/lsd/ && ln -sf ./colors-${(L)system_appearance}.yaml ./colors.yaml)
fi

###########
# Languages
###########
if (( $+commands[go] )); then
  export GOPATH=$HOME
  export GOROOT=$(go env GOROOT);
  path=($(go env GOPATH)/bin(N-/) $path)
fi

if (( $+commands[rye] )); then
  test -f ~/.rye/env || rye self install -y
  source ~/.rye/env
fi

if (( $+commands[composer] )); then
  path=($HOME/.composer/vendor/bin(N-/) $path)
fi

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
#    alias kc=kubectl
#fi


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

if [ "$DOTFILES/.secrets/.zshrc.local" -nt "~/.secrets/.zshrc.local.zwc" ]; then
  zcompile ~/.zshrc.local
fi
if [ "$DOTFILES/.zshrc" -nt "~/.zshrc.zwc" ]; then
  zcompile ~/.zshrc
fi

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

if (( $+commands[brew] )); then
  mkdir -p ~/.zfunc
  fpath+=~/.zfunc

  if [ ! -e ~/.zfunc/_rustup -a $+commands[rustup] ]; then
    rustup completions zsh > ~/.zfunc/_rustup
  fi
fi

autoload -Uz compinit
compinit -C

if (( $+commands[gh] )); then eval "$(gh completion -s zsh)"; fi
if (( $+commands[kubectl] )); then source <(kubectl completion zsh); fi

##################
# End of execution
##################
typeset -T LD_LIBRARY_PATH ld_library_path
typeset -U ld_library_path
typeset -T LIBRARY_PATH library_path
typeset -U library_path
typeset -U path PATH

# DEBUG: https://stevenvanbael.com/profiling-zsh-startup
#zprof
