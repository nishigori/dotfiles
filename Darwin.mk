# Makefile in nishigori/dotfiles
#
# For Darwin
#
BREW_TAPS =  omebrew/dupes \
             homebrew/versions \
             mcuadros/homebrew-hhvm

BREW_PKGS = brew-cask \
  cmake automake bsdmake \
  zsh bash \
  wget curl \
  coreutils gnu-sed pstree pcre readline tree \
  zlib libzip libxml2 libssh2 libtiff \
  libxslt libarchive libelf libevent \
  libffi libmagic libmemcached libpng jpeg libsodium \
  beecrypt lzop thrift \
  glog mcrypt  \
  libtasn1 libtool libyaml \
  bison unixodbc re2c \
  ack cscope jq ossp-uuid sshpass \
  tmux \
  autoconf ctags \
  lz4 pango tbb \
  lzo the_silver_searcher \
  dos2unix gmp \
  boost mhash rlwrap watch \
  gobject-introspection mysql rmtrash \
  cairo \
  imap-uw \
  oniguruma popt sl snappy \
  gettext splhack/splhack/gettext-mk \
  freetype harfbuzz neon rocksdb xz \
  icu4c nkf pixman \
  gflags \
  wxmac \
  openssl \
  fontconfig fontforge ricty figlet \
  gd imagemagick \
  pkg-config rpm rpm2cpio \
  osquery peco \
  mercurial git subversion tig gist gist-img \
  czmq zeromq \
  mysql-connector-c++ sqlite berkeley-db gdbm memcached \
  go gotags \
  gauche \
  erlang \
  ghc cabal-install \
  ocaml \
  lua luajit \
  nodebrew \
  rbenv ruby-build \
  pyenv pyenv-virtualenv python python3 pypy pypy3 \
  plenv perl-build cpanminus \
  php56 php56-mcrypt php56-xdebug php56-xhprof php56-msgpack \
  binutils hhvm \
  groovy \
  awscli s3cmd \
  packer rocket \
  jenkins-lts

BREW_CASK_PKGS = virtualbox vagrant dockertoolbox \
  google-chrome google-japanese-ime \
  alfred xtrafinder \
  flash adobe-reader gimp \
  atom \
  dropbox \
  iterm2 \
  macvim-kaoriya \
  slack

.PHONY: $(BREW_PKGS) $(BREW_CASK_PKGS) \
  Darwin/* brew/* brew_cask/* firefox/*

Darwin/install: brew/install brew_cask/install

Darwin/clean: brew/clean brew_cask/clean firefox/clean

Darwin/update: brew/update brew/upgrade brew_cask/update

brew/install: $(BREW_TAPS) $(BREW_PKGS)

$(BREW_TAPS):
	brew tap $@

$(BREW_PKGS):
	@brew install $@

brew/clean:
	brew cleanup

brew/update:
	brew update
	brew -v

brew/upgrade:
	brew upgrade

brew_cask/install: $(BREW_CASK_PKGS)

$(BREW_CASK_PKGS):
	@brew cask list | grep -q $@ || brew cask install $@

brew_cask/clean:
	brew cask cleanup

brew_cask/update:
	brew cask update

firefox/clean:
	find ~/Library/Application\ Support/Firefox/Profiles/ -maxdepth 2 -type f -name "*.sqlite" | xargs -I {} sqlite3 {} "VACUUM; REINDEX;"
