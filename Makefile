# Makefile in nishigori/dotfiles
#
SHELL := $(shell which zsh)
RC_FILES := $(wildcard .*rc)

# Internal variables that it is (maybe) you do not need to set.
os := $(shell uname -s)
credentials = .gitsecret .zshrc.local .vimrc.local .gvimrc.local
links = $(RC_FILES) .gitconfig bin tmp .zsh .vim .vimperator .zplug/init.zh
vim_requires = Shougo/neobundle.vim Shougo/vimproc

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
install:  $(os)/install shell/install vim

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

shell/install: ~/.zplug/zplug
	@echo Setup SHELL
	echo $$SHELL | grep -q $(SHELL) || chsh -s $(SHELL)
	$(SHELL) --version
	-time ( source ~/.$(notdir $(SHELL))rc )

~/.zplug/zplug:
	curl -fLo ~/.zplug/zplug --create-dirs https://git.io/zplug


vim: $(vim_requires)
	./bin/neobundle

$(vim_requires): clone_dir=.vim/bundle/$(notdir $@)
$(vim_requires):
	mkdir -p .vim/bundle
	test -d $(clone_dir) || git clone https://github.com/$@ $(clone_dir)
