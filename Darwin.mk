# Makefile in nishigori/dotfiles
#
# For Darwin
#
EDITOR := vscode
ifeq (arm64,$(arch))
BREW   := /opt/homebrew/bin/brew
VSCODE := /opt/homebrew/bin/code
else
BREW   := /usr/local/bin/brew
VSCODE := /usr/local/bin/code
endif

DEFAULT_ARCH := $(shell uname -m)

export HOMEBREW_NO_AUTO_UPDATE=1

.PHONY: Darwin/* brew/*

Darwin/install: $(BREW) brew/tap brew/bundle

Darwin/update: brew/update brew/upgrade

Darwin/clean: brew/cleanup

$(BREW):
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	#which mas 2>/dev/null || $(BREW) install mas
	brew tap Homebrew/bundle

brew/%:
	brew $(@F)

brew/bundle:
	brew bundle

vscode: json_dir := $(HOME)/Library/Application\ Support/Code/User
vscode: $(VSCODE)
	@find $(json_dir) -maxdepth 1 -type f -name 'settings.json' -o -name 'keybindings.json' | xargs rm -f
	ln -sf $(CURDIR)/.vscode/settings.json $(json_dir)/settings.json
	ln -sf $(CURDIR)/.vscode/keybindings.json $(json_dir)/keybindings.json
	# for vscodevim.vim extension: https://github.com/VSCodeVim/Vim#-installation
	-defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
	-defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false
	-defaults write com.visualstudio.code.oss ApplePressAndHoldEnabled -bool false
	-defaults write com.microsoft.VSCodeExploration ApplePressAndHoldEnabled -bool false
	-defaults delete -g ApplePressAndHoldEnabled

$(VSCODE): $(BREW)
	$(if $(wildcard $@),, brew cask install visual-studio-code)
	@mkdir -p ~/.vscode/extensions
