# Makefile in nishigori/dotfiles
#
RC_FILES := $(wildcard .*rc) .tmux.conf

# Internal variables that it is (maybe) you do not need to set.
os           := $(shell uname -s)
credentials  := .gitsecret .zshrc.local .zplugrc.local .vimrc.local .gvimrc.local
links        := $(RC_FILES) .gitconfig tmp .zsh .zshenv .vim .vimperator .config/dein .config/nvim
dir_requires := ~/src ~/bin ~/.cache/terraform ~/.config ~/Dropbox $(foreach _v,undo swap backup unite view,~/.cache/vim/$(_v))
bin_requires := bin/diff-highlight


.PHONY: me $(os)/*
.DEFAULT_GOAL: m3

me: $(dir_requires) $(bin_requires) links credentials
	@echo Make me happy :D

all: install lsp golang

# Declared on $(os).mk, It's template
$(os)/%:
	@echo $@: nothing todo

-include $(os).mk


.PHONY: clean install update $(links) $(credentials) shell/*

# Alias
install: me $(os)/install

clean: $(os)/clean

update: links $(os)/update

credentials: $(dir_requires) $(credentials)

links: $(dir_requires) $(links)
	true $(foreach _script, $(wildcard bin/*), && ln -sf $(CURDIR)/$(_script) ~/$(_script))
	ln -sf ~/Dropbox/TODO.rst ~/TODO.rst

$(credentials):
	$(if $(wildcard ~/$@),, /bin/cp -i ./$@.example ~/$@ && echo "U should edit ~/$@ just putting")

$(dir_requires):
	@mkdir -p $@

$(links):
	@ln -sf $(CURDIR)/$@ ~/$(@D)
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

lsp: # language-server
ifneq (,$(shell which go 2>/dev/null))
	go install golang.org/x/tools/gopls@latest
	go install github.com/sourcegraph/go-langserver@latest
endif
#ifneq (,$(shell which pip3 2>/dev/null))
#	pip3 install python-language-server
#endif

vim:
	# Requirements for https://github.com/Shougo/denite.nvim
	pip3 install --user pynvim

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
	# Others
	go install golang.org/x/lint/golint@latest
	go install github.com/monochromegane/dragon-imports/...@latest

goimports-update-ignore: ## Scan $GOPATH/src/ and generate a $GOPATH/src/.goimportsignore
	go get -u golang.org/x/tools/cmd/goimports
	go get -u github.com/pwaller/goimports-update-ignore
	rm -f $$GOPATH/src/.goimportsignore
	goimports-update-ignore

