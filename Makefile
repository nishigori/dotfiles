# Makefile in nishigori/dotfiles
#
SHELL    := $(shell which zsh)
RC_FILES := $(wildcard .*rc)

# Internal variables that it is (maybe) you do not need to set.
os := $(shell uname -s)
credentials  := .gitsecret .zshrc.local .zplugrc.local .vimrc.local .gvimrc.local
links        := $(RC_FILES) .gitconfig bin tmp .zsh .vim .vimperator .config/dein .config/nyaovim
dir_requires := ~/src ~/bin ~/.config/nvim ~/.cache/vim/{undo,swap,backup,unite,view}
bin_requires := ~/bin/diff-highlight ~/.zplug/init.zsh


.PHONY: help me $(os)/*
.DEFAULT_GOAL: help

help:
	@grep -E '^[a-zA-Z_%-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


all: me install

me: links credentials
	@echo Make me happy :D

# Declared on $(os).mk, It's template
$(os)/%:
	@echo $@: nothing todo

-include $(os).mk


.PHONY: clean install update $(links) $(credentials) shell/*

# Alias
install: $(dir_requires) $(bin_requires) $(os)/install zsh credentials

$(dir_requires):
	@mkdir -p $@

clean: $(os)/clean

update: links $(os)/update goimports-update-ignore

goimports-update-ignore:
	go get -u golang.org/x/tools/cmd/goimports
	go get -u github.com/pwaller/goimports-update-ignore
	rm -f $$GOPATH/src/.goimportsignore
	goimports-update-ignore

credentials: $(dir_requires) $(credentials)

$(credentials):
	@if ! [ -f ~/$@ ]; then \
		/bin/cp -i ./$@.example ~/$@; \
		echo "(maybe) U should edit $@ just putting"; \
	fi

links: $(dir_requires) $(links) neovimrc

$(links):
	@ln -sf $(CURDIR)/$@ ~/$(dir $@)
	@ls -dF ~/$@

neovimrc: ~/.config/nvim
	@ln -snfv $(HOME)/.vimrc $(HOME)/.config/nvim/init.vim


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
