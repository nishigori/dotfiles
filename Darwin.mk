# Makefile in nishigori/dotfiles
#
# For Darwin
#
VIM_FEATURE := HUGE
BREW_DOWNLOAD_URL := https://raw.githubusercontent.com/Homebrew/install/master/install


.PHONY: Darwin/* brew/* firefox/*

Darwin/install: brew/install brew/tap brew/bunle

Darwin/clean: brew/clean firefox/clean

Darwin/update: brew/update brew/upgrade

brew/install:
	/usr/bin/ruby -e "$$(curl -fsSL $(BREW_DOWNLOAD_URL))"

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
