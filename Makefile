# Makefile in nishigori/dotfiles
#
FEATURE := $(if $(CI),tiny,normal)

ifeq (,$(filter $(FEATURE), tiny normal huge))
 	# may outputs "*** recipe commences before first target.  Stop."
	$(error invalid FEATURE)
endif

# Internal variables that it is (maybe) you do not need to set.
huge          := $(findstring huge, $(FEATURE))
os            := $(shell uname -s)
arch           = $(shell arch)
secrets       := $(subst .example,,$(wildcard .secrets/.*.example))
rc_files      := $(wildcard .*rc) .luarc.json .wezterm.lua .tmux.conf
links         := $(rc_files) $(wildcard .config/*) .zsh .vim .secrets .gitconfig
dir_requires  := $(addprefix $(HOME)/, src bin tmp .config .cache/terraform .local/bin) \
	$(addprefix $(HOME)/.cache/vim/, undo swap backup unite view) \
	$(if $(huge), $(addprefix $(HOME)/, Dropbox))

.DEFAULT_GOAL: me
.PHONY: me
me: $(dir_requires) links secrets
	# make me happy :D

.PHONY: all
all: me install update

# Declared on $(os).mk, It's template
$(os)/%:
	@echo $@: nothing todo

-include $(os).mk


.PHONY: clean install update $(links) shell/*

# Alias
install: me $(os)/install bin lang $(if $(huge), gh)
update: links $(os)/update bin lang $(if $(huge), gh)
lang: mise rustup

clean: $(os)/clean
ifneq (,$(shell which docker 2>/dev/null))
	docker image prune -a --filter "until=$$(date '+%Y-%m-%d' --date '365 days ago')"
endif
	$(if $(shell which cargo), cargo cache -a)

secrets: $(dir_requires) $(secrets)

links: $(dir_requires) $(links)
	@$(if $(huge), ln -sf ~/Dropbox/TODO.rst, touch) $(HOME)/TODO.rst

.PHONY: bin
bin_externals := bin/diff-highlight bin/git-delete-squashed-branches

bin: ~/.local/bin $(bin_externals) # NOTE: `for..in` is (delay) considered for deploying from other make-target.
	@for b in `cd bin && /bin/ls *`; do \
		set -e; \
		test -L $</$$b || (set -x; ln -sf $(CURDIR)/bin/$$b $</$$b); \
		ls -F $</$$b; \
	done

.PHONY: $(secrets)
$(secrets):
	$(if $(wildcard $@),,cp -i $@.example $@ && echo "U should edit $@ just putting now")
	@ln -sf $(CURDIR)/$@ ~/
	@ls -dF ~/$@

$(dir_requires):
	@mkdir -p $@

$(links):
	@ln -sf $(CURDIR)/$@ ~/$(@D)
	@ls -dF ~/$@

.PHONY: gh
gh_extensions := mislav/gh-branch dlvhdr/gh-dash

gh: $(gh_extensions)
	gh extension upgrade --all
	gh version

$(gh_extensions):
	$(if $(filter $@, $(shell gh extension list 2>/dev/null)),, gh extension install $@)

.PHONY: mise
mise: .config/mise
	mise -C ~/$< install


bin/diff-highlight: # NOTE: `if..which` is (delay) considered for deploying from other make-target.
	@if [ -z "`which $(@F)`" ]; then \
		set -ex; \
		git clone --depth=1 --no-single-branch --no-tags https://github.com/git/git /tmp/git; \
		make -C /tmp/git/contrib/diff-highlight/; \
		mv /tmp/git/contrib/diff-highlight/diff-highlight $@; \
		rm -rf /tmp/git; \
	fi

bin/git-delete-squashed-branches:
	curl -SsL -o $@ https://raw.githubusercontent.com/tj/git-extras/master/bin/git-delete-squashed-branches
	chmod +x $@

vim:
ifeq (,$(wildcard ~/.local/share/nvim/site/pack/packer/start/packer.nvim))
	mkdir -p ~/.local/share/nvim/site/pack/packer/start/
	# https://github.com/wbthomason/packer.nvim#quickstart
	git clone --depth 1 https://github.com/wbthomason/packer.nvim \
		~/.local/share/nvim/site/pack/packer/start/packer.nvim
endif

rustup:
ifneq (,$(shell which rustup))
	rustup show
	rustup component list --installed
endif
