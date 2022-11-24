# Makefile in nishigori/dotfiles
#
RC_FILES := $(wildcard .*rc) .luarc.json .wezterm.lua .tmux.conf

# Internal variables that it is (maybe) you do not need to set.
os            := $(shell uname -s)
arch           = $(shell arch)
secrets       := $(subst .example,,$(wildcard .secrets/.*.example))
links         := $(RC_FILES) .gitconfig .zsh .zshenv .p10k.zsh .vim .secrets
links         += $(addprefix .config/, dein nvim gh prs cspell firefox tridactyl)
dir_requires  := $(addprefix $(HOME)/, src, bin, tmp, Dropbox .config, .cache/terraform) \
	$(addprefix $(HOME)/.cache/vim/, undo swap backup unite view)
bin_requires  := $(if $(shell which diff-highlight),, bin/diff-highlight)
gh_extensions := mislav/gh-branch dlvhdr/gh-dash

.DEFAULT_GOAL: me
.PHONY: me
me: $(dir_requires) $(bin_requires) links secrets
	@echo Make me happy :D

.PHONY: all
all: install lsp golang

# Declared on $(os).mk, It's template
$(os)/%:
	@echo $@: nothing todo

-include $(os).mk


.PHONY: clean install update $(links) shell/*

# Alias
install: me $(os)/install

clean: $(os)/clean

update: links $(os)/update

secrets: $(dir_requires) $(secrets)

links: $(dir_requires) $(links)
	@set -ex; $(foreach _script, $(wildcard bin/*), ln -sf $(CURDIR)/$(_script) ~/$(_script);)
	ln -sf ~/Dropbox/TODO.rst ~/TODO.rst

$(secrets):
	cp -i $@.example $@
	@echo "U should edit $@ just putting now"

$(dir_requires):
	@mkdir -p $@

$(links):
	@ln -sf $(CURDIR)/$@ ~/$(@D)
	@ls -dF ~/$@

terminal: $(os)/terminal

zsh: $(HOME)/.zinit $(HOME)/.zsh_history ## Configure ZSH

$(HOME)/.zsh_history:
	fc -p $@

$(HOME)/.zinit:
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

github: $(gh_extensions)

$(gh_extensions):
	$(if $(filter $@, $(shell gh extension list)),, gh extension install $@)

bin/diff-highlight:
	git clone --depth=1 --no-single-branch --no-tags https://github.com/git/git /tmp/git
	make -C /tmp/git/contrib/diff-highlight/
	mv /tmp/git/contrib/diff-highlight/diff-highlight $@

lsp: # language-server
ifneq (,$(shell which go 2>/dev/null))
	go install golang.org/x/tools/gopls@latest
	go install github.com/sourcegraph/go-langserver@latest
endif

vim:
ifeq (,$(wildcard ~/.local/share/nvim/site/pack/packer/start/packer.nvim))
	mkdir -p ~/.local/share/nvim/site/pack/packer/start/
	# https://github.com/wbthomason/packer.nvim#quickstart
	git clone --depth 1 https://github.com/wbthomason/packer.nvim \
		~/.local/share/nvim/site/pack/packer/start/packer.nvim
endif

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
