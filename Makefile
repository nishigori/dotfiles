# Makefile in nishigori/dotfiles
#
SHELL := $(shell which zsh)
RC_FILES := $(wildcard .*rc)

# Internal variables that it is (maybe) you do not need to set.
os := $(shell uname -s)
credentials = .gitsecret .zsh/zgenrc_local
links = $(RC_FILES) .gitconfig bin tmp .zsh .vim .vimperator

.PHONY: help $(os)/*

help:
	@more Makefile

# Declared on $(os).mk, It's template
$(os)/%:
	@echo $@: nothing todo

-include $(os).mk


.PHONY: clean me install update \
  $(links) $(credentials) shell* vim

me: links credentials $(os)/install shell/install
	@echo Make me happy :D

# Alias
install: me

clean: $(os)/clean shell/clean

update: links $(os)/update shell/update

credentials: $(credentials)

$(credentials):
	@if ! [ -f ~/$@ ]; then \
		/bin/cp -i ./$@.example ~/$@; \
		echo "(maybe) U should edit $@ just putting"; \
	fi

links: $(links)

$(links):
	@test -h ~/$@ || ln -s $(CURDIR)/$@ ~/
	@ls -ld ~/$@

shell/install:
	@echo Setup SHELL
	echo $$SHELL | grep -q $(SHELL) || chsh -s $(SHELL)
	$(SHELL) --version
	-time ( source ~/.$(notdir $(SHELL))rc )

shell/clean:
	-. ~/.$(notdir $(SHELL))rc && zgen-reset

shell/update:
	. ~/.$(notdir $(SHELL))rc && zgen-selfupdate

vim:
	./bin/neobundle
