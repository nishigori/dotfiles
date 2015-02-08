# Prepare installation for Merverick
# xcode-select —install

# sshpass
# brew install https://raw.github.com/eugeneoden/homebrew/eca9de1/Library/Formula/sshpass.rb

# Add repositories
tap homebrew/versions || true
tap caskroom/cask || true
tap caskroom/versions || true

# Update Homebrew
update || true
upgrade

# Install formulae
install brew-cask || true
install zsh || true
install wget || true
install tig || true

cask install alfred || true

# Core Commands
install ack || true
install ag || true

# VCS
install git || true
install subversion || true

# Fonts
tap sanemat/font
install ricty

# Vim
tap supermomonga/homebrew-splhack || true
install ctags || true
install cscope || true
install lua || true
install --HEAD cmigemo-mk || true
install --HEAD ctags-objc-ja || true
install macvim-kaoriya --HEAD --with-lua --with-cscope || true

# Vimperator for Mac
install gnu-sed || true
install coreutils || true

# Ruby
install rbenv || true
install ruby-build || true

# Go
install go --with-cc-common || true

# Install Cask formulae
cask install google-chrome || true
#cask install intellij-idea || true

# Java
cask install java

# Node.js
install nodebrew || true

# Perl
install plenv || true
install perl-build || true

cask install iterm2

# VM tools
cask install virtualbox
cask install vagrant
tap homebrew/binary
install packer || true

# SICP
install gauche || true
install rlwrap || true

cask install google-japanese-ime
cask install adobe-reader
cask install flash
cask install xtrafinder

cask install dropbox

# Docker
# See: http://qiita.com/hakobera/items/db73c5531d65cfeed7ce
cask install boot2docker
