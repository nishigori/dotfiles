# Makefile in nishigori/dotfiles
#
SHELL    := $(shell which zsh)
RC_FILES := $(wildcard .*rc)

# Internal variables that it is (maybe) you do not need to set.
os           := $(shell uname -s)
credentials  := .gitsecret .zshrc.local .zplugrc.local .vimrc.local .gvimrc.local
links        := $(RC_FILES) .gitconfig tmp .zsh .vim .vimperator .config/dein .config/nyaovim .config/oni
dir_requires := ~/src ~/bin ~/.cache/vim/{undo,swap,backup,unite,view} ~/.cache/terraform ~/Dropbox
bin_requires := bin/diff-highlight


.PHONY: help me $(os)/*
.DEFAULT_GOAL: help

help:
	@awk -F ':|##' '/^[^\t].+?:.*?##/ { printf "\033[36m%-25s\033[0m %s\n", $$1, $$NF }' $(MAKEFILE_LIST)


all: me install

me: links credentials
	@echo Make me happy :D

# Declared on $(os).mk, It's template
$(os)/%:
	@echo $@: nothing todo

-include $(os).mk


.PHONY: clean install update $(links) $(credentials) shell/*

# Alias
install: $(dir_requires) $(bin_requires) $(os)/install zsh credentials golang

$(dir_requires):
	@mkdir -p $@

clean: $(os)/clean

update: links $(os)/update

credentials: $(dir_requires) $(credentials)

$(credentials):
	$(if $(wildcard ~/$@),, /bin/cp -i ./$@.example ~/$@ && echo "(maybe) U should edit ~/$@ just putting")

links: $(dir_requires) $(links)
	true $(foreach _script, $(wildcard bin/*), && ln -sf $(CURDIR)/$(_script) ~/$(_script))
	ln -sf ~/Dropbox/TODO.rst ~/TODO.rst

$(links):
	@ln -sf $(CURDIR)/$@ ~/$(dir $@)
	@ls -dF ~/$@

zsh: ~/.zplugin/bin ~/.zsh_history ## Configure ZSH

~/.zsh_history:
	fc -p $(HOME)/.zsh_history

~/.zplugin/bin:
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

bin/diff-highlight:
	git clone --depth=1 --no-single-branch --no-tags https://github.com/git/git /tmp/git
	make -C /tmp/git/contrib/diff-highlight/
	mv /tmp/git/contrib/diff-highlight/diff-highlight $@

golang: ## Setup Go language
	# Standard
	go get -u golang.org/x/tools/cmd/...
	go get -u golang.org/x/tools/cmd/godoc
	# REPL
	go get -u github.com/mdempsky/gocode
	go get -u github.com/k0kubun/pp
	go get -u github.com/mightyguava/ecsq
	go get -u github.com/d4l3k/go-pry
	go install -i github.com/d4l3k/go-pry
	# LSP (Language Server Protocol)
	go get -u golang.org/x/tools/cmd/gopls
	go get -u github.com/sourcegraph/go-langserver
	# Others
	go get golang.org/x/lint/golint
	go get github.com/monochromegane/dragon-imports/...

goimports-update-ignore: ## Scan $GOPATH/src/ and generate a $GOPATH/src/.goimportsignore
	go get -u golang.org/x/tools/cmd/goimports
	go get -u github.com/pwaller/goimports-update-ignore
	rm -f $$GOPATH/src/.goimportsignore
	goimports-update-ignore

