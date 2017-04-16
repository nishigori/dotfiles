# Makefile in nishigori/dotfiles
#
# For Darwin
#
VIM_FEATURE := HUGE

BREW              := /usr/local/bin/brew
BREW_MAS          := /usr/local/bin/mas
BREW_DOWNLOAD_URL := https://raw.githubusercontent.com/Homebrew/install/master/install


.PHONY: Darwin/* brew/* firefox/*

Darwin/install: $(BREW) $(BREW_MAS) brew/tap brew/bundle
	@echo "\nManually Installations:"
	@echo "MacVim Kaoriya: https://github.com/splhack/macvim-kaoriya/releases"
	@echo "F.lux: https://justgetflux.com/"

Darwin/clean: brew/clean firefox/clean

Darwin/update: brew/update brew/upgrade

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

firefox/clean:
	find ~/Library/Application\ Support/Firefox/Profiles/ -maxdepth 2 -type f -name "*.sqlite" | xargs -I {} sqlite3 {} "VACUUM; REINDEX;"

Darwin/docker.start:
	@echo "Darwin is other handle Docker for Mac as unused docker-toolbox"
