# Makefile in nishigori/dotfiles
#
SHELL    := $(shell which zsh)
RC_FILES := $(wildcard .*rc)

DOCKER_ENV:=default

# Internal variables that it is (maybe) you do not need to set.
os := $(shell uname -s)
credentials  := .gitsecret .zshrc.local .zplugrc.local .vimrc.local .gvimrc.local
links        := $(RC_FILES) .gitconfig bin tmp .zsh .vim .vimperator .config/dein
vim_requires := Shougo/dein.vim
dir_requires := ~/src ~/bin ~/.config ~/.config/nvim/ ~/.cache/vim/{undo,swap,backup,unite,view}
bin_requires := ~/bin/diff-highlight ~/.zplug/init.zsh


.PHONY: help me $(os)/*
.DEFAULT_GOAL: help

help:
	@grep -E '^[a-zA-Z_%-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


all: me install vim

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
install: $(dir_requires) $(bin_requires) $(os)/install zsh credentials

$(dir_requires):
	@mkdir -p $@

clean: $(os)/clean

update: links $(os)/update

credentials: $(dir_requires) $(credentials)

$(credentials):
	@if ! [ -f ~/$@ ]; then \
		/bin/cp -i ./$@.example ~/$@; \
		echo "(maybe) U should edit $@ just putting"; \
	fi

links: $(dir_requires) $(links)

$(links):
	@ln -sf $(CURDIR)/$@ ~/$(dir $@)
	@ls -dF ~/$@


zsh: ~/.zplug/init.zsh ~/.zsh_history chsh_zsh ## Configure ZSH

chsh_zsh:
	@echo Setup SHELL
	grep -q $(SHELL) /etc/shells || sudo sh -c "echo '$(SHELL)' >> /etc/shells"
	echo $$SHELL | grep -q $(SHELL) || chsh -s $(SHELL)
	$(SHELL) --version
	-time ( source ~/.$(notdir $(SHELL))rc )

~/.zsh_history:
	fc -p $(HOME)/.zsh_history

~/.zplug/init.zsh:
	curl -sL --proto-redir -all,https https://zplug.sh/installer | zsh

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
