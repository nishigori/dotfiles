# Brewfile
#
# HACK: via Makefile, split for mode tiny|normal|huge
#
# vim: set ft=config expandtab:

# Tap of the head
tap 'homebrew/bundle'

brew 'git'
brew 'mise' # alternative anyenv, asdf
brew 'curl'
brew 'jq'

# Common Utils
brew 'apr-util'
brew 'arm-none-eabi-binutils'
#brew 'binutils' # perl buildでldflagsコケるかも https://anatofuz.hatenablog.com/entry/2019/02/12/160854
brew 'coreutils'
brew 'diffutils'
brew 'docutils'
brew 'findutils'

# GNU alternative
brew 'gawk'
brew 'gnutls'
brew 'gnu-sed'
brew 'gnu-tar'
brew 'gnu-time'
brew 'gnu-which'
brew 'gpg'

# Shell
brew 'zsh'
brew 'zinit'

##############################################################
# HACK: Don't remove '@@' above line cause handled by Makefile
# @@ End of mode-tiny
##############################################################

cask_args appdir: '/Applications'

# Tap of the head
tap 'homebrew/cask-versions'
tap 'homebrew/cask-fonts'
tap 'sanemat/font'
tap 'aws/tap'
tap 'wez/wezterm'
tap 'hashicorp/tap'

# Desktop App
cask 'ghostty'
cask 'wezterm'
cask 'dash'
cask 'firefox'
cask 'spectacle' # Migrated from rectangle
cask 'raycast' # launcher Migrated from spotlight, and alfred

# Font, IME
cask 'google-japanese-ime'
cask 'font-hack-nerd-font'
brew 'fontconfig'


#######################
# Compiler, Build-tools
#######################
brew 'automake'
brew 'bazel'
#brew 'bsdmake'
brew 'cmake'
brew 'glib'
brew 'gcc'
brew 'llvm'
brew 'make'
brew 'pcre'
brew 'pkg-config'


#####
# VCS
#####
brew 'git-delta'
brew 'lazygit'
brew 'tig'


######################
# Languages, Toolchain
######################
brew 'editorconfig'
brew 'editorconfig-checker'
brew 'cargo-binstall'
brew 'cpanminus'
#brew 'rebar3'
#brew 'rust' # from mise
#brew 'ghc'
brew 'rye'
brew 'python'
# lsp managed by lazyvim
#brew 'terraform_landscape' # lsp
#brew 'terraform-ls' # lsp


#############
# Editor, IDE
#############
cask 'macvim'
brew 'tree-sitter'
brew 'neovim'
#brew 'vim'

# 'vscode --install-extension'
#vscode "GitHub.codespaces"


###########
# Container
###########
#cask 'docker'
brew 'k9s'
brew 'stern' #  Tail multiple Kubernetes pods & their containers


######
# HTTP
######
cask 'httpie'
brew 'nghttp2'


##########
# Database
##########
brew 'sqlite'
brew 'mysql-client'


########
# GitHub
########
brew 'gh'
brew 'ghq'
brew 'hub'


#######
# Cloud
#######
cask 'aws-vault'
brew 'awscli'
#brew 'aws/tap/copilot-cli'
cask 'session-manager-plugin'

cask 'google-cloud-sdk'

brew 'packer'

brew 'fastly/tap/fastly'
brew 'falco' # Fastly VCL developer tool


####################
# CommandLine Tools
###################
brew 'procs'       # Powerful 'ps' https://github.com/dalance/procs
brew 'bat'         # Powerful 'cat' https://github.com/sharkdp/bat
brew 'bat-extras'  # https://github.com/eth-p/bat-extras/blob/master/README.md
brew 'fd'          # Powerful 'find' https://github.com/sharkdp/fd
brew 'ripgrep'     # Powerful 'grep' https://github.com/BurntSushi/ripgrep
brew 'lsd'         # Powerful 'ls' https://github.com/lsd-rs/lsd
brew 'act'         # github actions runner on local
brew 'direnv'      # will be migrate to https://mise.jdx.dev/direnv.etml
brew 'fzf'         # Migrated from sk
brew 'atuin'       # Shell history with a SQLite database
brew 'pre-commit'  # TODO: recommended to migrate 'lefthook' (written in mise)
brew 'yq'
brew 'xq'
brew 'netmask'
brew 'tmux'
brew 'wget'
brew 'watch'
brew 'tree'
brew 'telnet'

##############################################################
# HACK: Don't remove '@@' above line cause handled by Makefile
# @@ End of mode-normal
##############################################################


brew 'mas' # brew utils

mas 'Slack', id: 803_453_959
cask '1password' #mas '1Password', id: 443_987_910
#mas 'TweetDeck', id: 485_812_721

#cask 'intellij-idea' # now, migrated to jetbrains-toolbox
cask 'jetbrains-toolbox'

# multi app manager
#cask 'franz'

cask 'microsoft-edge@beta'
cask 'google-chrome'

cask 'deepl'
cask 'discord'
cask 'dropbox'
cask 'kindle'
cask 'notion'
cask 'messenger'
cask 'visual-studio-code'
cask 'homebrew/cask-drivers/zsa-wally' # ZSA Kayboard the EZ way
cask 'font-victor-mono'
cask 'font-victor-mono-nerd-font'
#cask 'gifcapture'
#cask 'krisp'


##############################################################
# HACK: Don't remove '@@' above line cause handled by Makefile
# @@ End of mode-huge
##############################################################
