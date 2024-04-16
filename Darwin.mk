# Makefile in nishigori/dotfiles
#
# For Darwin
#
EDITOR    := nvim
BREW_ROOT := $(if $(filter arm64,$(shell arch)), /opt/homebrew, /usr/local)
BREW      := $(BREW_ROOT)/bin/brew
VSCODE    := $(BREW_ROOT)/bin/code

XCODE_REQ_INSTALL = $(shell xcode-select -p 1>/dev/null || echo "not installed")

export HOMEBREW_NO_AUTO_UPDATE=1
# HACK: For one-step make install
export PATH := $(basename $(BREW)):$(BREW_ROOT)/opt/git/share/git-core/contrib/diff-highlight/:$(PATH)

.PHONY: Darwin/* brew/*

Darwin/install: xcode-select brew/tap brew/bundle

Darwin/update: brew/update brew/upgrade brew/bundle

Darwin/clean: brew/cleanup
	rm -f Brewfile.*

xcode-select:
	$(if $(XCODE_REQ_INSTALL), xcode-select --install && sudo xcodebuild -license accept)

$(BREW):
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	#which mas 2>/dev/null || $(BREW) install mas
	$@ tap Homebrew/bundle

brew/%: $(BREW)
	$< $(@F)

brew/bundle: $(BREW) Brewfile.$(FEATURE)
	$< $(@F) --file Brewfile.$(FEATURE)

Brewfile.%: Brewfile
	# assert
	grep -q "# @@ End of mode-$*" Brewfile
	sed "/@@ End of mode-$*/q" Brewfile > $@

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
