# Makefile in nishigori/dotfiles
#
# For Darwin
#
EDITOR := nvim
ifeq (arm64,$(arch))
BREW   := /opt/homebrew/bin/brew
VSCODE := /opt/homebrew/bin/code
else
BREW   := /usr/local/bin/brew
VSCODE := /usr/local/bin/code
endif

DEFAULT_ARCH      := $(shell uname -m)
XCODE_REQ_INSTALL  = $(shell xcode-select -p 1>/dev/null || echo "not installed")

export HOMEBREW_NO_AUTO_UPDATE=1
# For one-step install
export PATH := $(basename $(BREW)):$(PATH)

.PHONY: Darwin/* brew/*

# NOTE: brew/bundle is heavy run, skipped on CI
Darwin/install: xcode-select brew/tap $(if $(CI),,brew/bundle)

Darwin/update: brew/update brew/upgrade

Darwin/clean: brew/cleanup
	rm -f Brewfile

Darwin/terminal: # https://wezfurlong.org/wezterm/install/macos.html
ifeq (,$(shell which wezterm 2>/dev/null))
	brew tap wez/wezterm
	brew install --cask wezterm
endif

xcode-select:
	$(if $(XCODE_REQ_INSTALL), xcode-select --install && sudo xcodebuild -license accept)

$(BREW):
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	#which mas 2>/dev/null || $(BREW) install mas
	$@ tap Homebrew/bundle

Brewfile: Brewfile.normal $(if $(IS_HUGE), Brewfile.huge)
	cat $^ > $@

brew/%: $(BREW) Brewfile
	$< $(@F)

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
