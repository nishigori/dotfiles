# Makefile in nishigori/dotfiles
#
SHELL := $(shell which zsh)
RC_FILES := $(wildcard .*rc)

DOCKER_ENV:=default

# Internal variables that it is (maybe) you do not need to set.
os := $(shell uname -s)
credentials = .gitsecret .zshrc.local .vimrc.local .gvimrc.local .zplug/init.zsh
links = $(RC_FILES) .gitconfig bin tmp .zsh .vim .vimperator .config/dein
vim_requires = Shougo/dein.vim
dir_requires = ~/src ~/bin ~/.config ~/.config/nvim/
bin_requires = ~/bin/diff-highlight

.PHONY: me $(os)/*

me: links credentials
	@echo Make me happy :D

# Declared on $(os).mk, It's template
$(os)/%:
	@echo $@: nothing todo

# Each OS variables but the defaults
VIM_FEATURE := TINY

-include $(os).mk


.PHONY: clean install update \
  $(links) $(credentials) shell/* vim

# Alias
install: $(dir_requires) $(bin_requires) $(os)/install shell/install credentials vim

$(dir_requires):
	@mkdir -p $@

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
	@ln -sf $(CURDIR)/$@ ~/$(dir $@)
	@ls -dF ~/$@

shell/install: ~/.zplug/zplug
	@echo Setup SHELL
	echo $$SHELL | grep -q $(SHELL) || chsh -s $(SHELL)
	$(SHELL) --version
	-time ( source ~/.$(notdir $(SHELL))rc )

~/.zplug/zplug:
	curl -fLo ~/.zplug/zplug --create-dirs https://git.io/zplug


~/bin/diff-highlight: ~/bin
	curl -LSs -o $@ https://raw.githubusercontent.com/git/git/master/contrib/diff-highlight/diff-highlight
	chmod +x $@

vim: $(vim_requires)

$(vim_requires): clone_dir=.vim/dein/repos/github.com/$(notdir $@)
$(vim_requires):
	mkdir -p .vim/dein/repos/github.com/
	test -d $(clone_dir) || git clone https://github.com/$@ $(clone_dir)

neovim: $(dir_requires) $(vim_requires)
	ln -snfv $$HOME/.vim $$HOME/.config/nvim/
	ln -snfv $$HOME/.vimrc $$HOME/.config/nvim/init.vim

docker.start: $(os)/docker.start
