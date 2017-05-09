# Makefile in nishigori/dotfiles
#
# For Darwin
#
VIM_FEATURE := HUGE

BREW              := /usr/local/bin/brew
BREW_MAS          := /usr/local/bin/mas
BREW_DOWNLOAD_URL := https://raw.githubusercontent.com/Homebrew/install/master/install

MYFONTS_DIR := $(HOME)/.fonts


.PHONY: Darwin/* brew/* firefox/* fonts/* neovim/* nyaovim/*

Darwin/install: $(BREW) $(BREW_MAS) brew/tap brew/bundle fonts/all neovim/update nyaovim/install
	@echo "\nManually Installations:"
	@echo "MacVim Kaoriya: https://github.com/splhack/macvim-kaoriya/releases"
	@echo "F.lux: https://justgetflux.com/"

Darwin/update: brew/update brew/upgrade fonts/all neovim/update nyaovim/update

Darwin/clean: brew/clean firefox/clean

$(BREW):
	/usr/bin/ruby -e "$$(curl -fsSL $(BREW_DOWNLOAD_URL))"

$(BREW_MAS):
	$(BREW) install mas

brew/tap:
	brew tap Homebrew/bundle

brew/bundle:
	brew bundle

brew/clean:
	brew bundle cleanup
	brew cask cleanup

brew/update:
	brew update
	brew -v

brew/upgrade:
	brew upgrade

fonts/all: $(MYFONTS_DIR) fonts/ricty
	-fc-cache -v --error-on-no-fonts --force $<

$(MYFONTS_DIR):
	@mkdir $@

fonts/ricty: $(MYFONTS_DIR)
	/bin/cp -f $$(ls -td -- /usr/local/Cellar/ricty/* | head -n 1)/share/fonts/*.ttf $<

neovim/update: ## Preinstall by Brewfile
	pip2 install --user --upgrade neovim
	pip3 install --user --upgrade neovim
	-gem install neovim
	-gem update neovim

nyaovim/install:
	npm ls -g $(@D) || npm $(@F) -g $(@D)

nyaovim/update:
	npm $(@F) -g $(@D)


firefox/clean:
	find ~/Library/Application\ Support/Firefox/Profiles/ -maxdepth 2 -type f -name "*.sqlite" | xargs -I {} sqlite3 {} "VACUUM; REINDEX;"
