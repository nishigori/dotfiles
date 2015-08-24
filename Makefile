# Makefile in nishigori/dotfiles
#
SHELL = zsh

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
  go \
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
  slack


.PHONY: help install update upgrade \
    $(BREW_PKGS) $(BREW_CASK_PKGS) \
    shell

help:
	more Makefile

test:
	@echo $@

install: $(BREW_PKGS) $(BREW_CASK_PKGS) \
    shell
	@echo Make me happy :D

update:
	brew update
	brew -v

upgrade:
	brew upgrade

brew_pkgs: $(BREW_PKGS)

$(BREW_PKGS):
	brew install $@

brew_cask_pkgs: $(BREW_CASK_PKGS)

$(BREW_CASK_PKGS):
	brew cask install $@

shell: shell_bin := $(shell which $(SHELL))
shell:
	@echo Setup SHELL
	echo $$SHELL | grep -q $(SHELL) || chsh -s $(shell_bin)
	$(shell_bin) --version
