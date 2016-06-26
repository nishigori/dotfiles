# Makefile in nishigori/dotfiles
#
# For Darwin
#
VIM_FEATURE := HUGE


.PHONY: Darwin/* brew/* firefox/*

Darwin/install: brew/bundle

Darwin/clean: brew/clean firefox/clean

Darwin/update: brew/update brew/upgrade

brew/bundle:
	brew bundle -v

brew/clean:
	brew bundle cleanup

brew/update:
	brew update
	brew -v

brew/upgrade:
	brew upgrade

firefox/clean:
	find ~/Library/Application\ Support/Firefox/Profiles/ -maxdepth 2 -type f -name "*.sqlite" | xargs -I {} sqlite3 {} "VACUUM; REINDEX;"

Darwin/docker.start:
	@which docker-machine
	docker-machine start $(DOCKER_ENV)
	eval "$$(docker-machine env $(DOCKER_ENV))"
