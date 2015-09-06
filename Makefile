# Makefile in nishigori/dotfiles
#
SHELL := $(shell which zsh)
RC_FILES := $(wildcard .*rc)

# Internal variables that it is (maybe) you do not need to set.
os := $(shell uname -s)
links = $(RC_FILES) bin tmp .zsh .vim .vimperator

.PHONY: help $(os)/*

help:
	@more Makefile

# Declared on $(os).mk, It's template
$(os)/%:
	@echo $@: nothing todo

-include $(os).mk


.PHONY: clean me install update \
  $(links) shell*

me: links $(os)/install shell
	@echo Make me happy :D

# Alias
install: me

clean: $(os)/clean
	zgen selfupdate

update: links $(os)/update shell/update

links: $(links)

$(links):
	test -h ~/$@ || ln -s $(CURDIR)/$@ ~/

shell:
	@echo Setup SHELL
	echo $$SHELL | grep -q $(SHELL) || chsh -s $(SHELL)
	$(SHELL) --version
	time ( source ~/.$(notdir $(SHELL))rc )

shell/update:
	zgen selfupdate
