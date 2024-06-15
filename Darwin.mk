# Makefile in nishigori/dotfiles
#
# For Darwin
#
EDITOR    := nvim
BREW_ROOT := $(if $(filter arm64,$(shell arch)),/opt/homebrew,/usr/local)
BREW      := $(BREW_ROOT)/bin/brew
VSCODE    := $(BREW_ROOT)/bin/code

XCODE_REQ_INSTALL = $(shell xcode-select -p 1>/dev/null || echo "not installed")

export HOMEBREW_NO_AUTO_UPDATE=1
# HACK: For one-step make install
export PATH := $(basename $(BREW)):$(BREW_ROOT)/opt/git/share/git-core/contrib/diff-highlight/:$(PATH)

.PHONY: Darwin/* brew/*

Darwin/install: xcode-select brew/tap brew/bundle $(if $(CI),, firefox .macos-installed)

# NOTE: CI has brew's more pkgs, and conflict when brew/update
Darwin/update: brew/bundle $(if $(CI),, brew/update brew/upgrade firefox .macos-installed)

Darwin/clean: brew/cleanup
	rm -f Brewfile .*-installed

xcode-select:
	$(if $(XCODE_REQ_INSTALL), xcode-select --install && sudo xcodebuild -license accept)

.macos-installed: .macos
	./$<
	@touch $@

$(BREW):
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	#which mas 2>/dev/null || $(BREW) install mas
	$@ tap Homebrew/bundle

brew/%: $(BREW)
	$< $(@F)

brew/bundle: $(BREW) Brewfile
	$< $(@F)

Brewfile: .Brewfile
	grep -q "# @@ End of mode-$(FEATURE)" $< # assert
	sed "/@@ End of mode-$(FEATURE)/q" $< > $@

# https://support.mozilla.org/ja/kb/profiles-where-firefox-stores-user-data
firefox: .mozilla/firefox/profiles
	@(set -e; for p in `ls $</ | grep .default`; do \
		: 'Hide Top tab-bar (proton)'; \
		mkdir -p $</$$p/chrome/; \
		ln -sf $(CURDIR)/$(<D)/userChrome.css $</$$p/chrome/; \
		ls -dF $</$$p/chrome/userChrome.css; \
		: 'link to user.js for custom about:config'; \
		ln -sf $(CURDIR)/$(<D)/user.js $</$$p/; \
		ls -dF $</$$p/user.js; \
	done)

.mozilla/firefox/profiles: # I don't like directory with space
	@ln -sf ~/Library/Application\ Support/Firefox/Profiles/ $@
	@ls -dF $@

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
