# Makefile in nishigori/dotfiles
#
SHELL := $(shell which zsh)
RC_FILES := $(wildcard .*rc)

# Internal variables that it is (maybe) you do not need to set.
os := $(shell uname -s)
credentials = .gitsecret .zshrc.local .vimrc.local .gvimrc.local
links = $(RC_FILES) .gitconfig bin tmp .zsh .vim .vimperator

.PHONY: me $(os)/*

me: links credentials
	@echo Make me happy :D

# Declared on $(os).mk, It's template
$(os)/%:
	@echo $@: nothing todo

-include $(os).mk


.PHONY: clean install update \
  $(links) $(credentials) shell/* vim

# Alias
install:  $(os)/install shell/install

clean: $(os)/clean

update: links $(os)/update

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

vim:
	./bin/neobundle
