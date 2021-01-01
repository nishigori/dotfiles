# Makefile in nishigori/dotfiles
#
# For Darwin
#
EDITOR      := vscode
BREW        := /usr/local/bin/brew
BREW_MAS    := /usr/local/bin/mas

VSCODE            := /usr/local/bin/code
VSCODE_EXTENSIONS := $(shell grep -v -e '^\#' -e '^$$' .vscode/_plugins.txt)

export HOMEBREW_NO_AUTO_UPDATE=1

.PHONY: Darwin/* brew/*

Darwin/install: $(BREW) brew/tap brew/bundle $(EDITOR)

Darwin/update: brew/update brew/upgrade

Darwin/clean: brew/cleanup

$(BREW):
	/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	@test -f /usr/local/bin/mas || $(BREW) install mas
	brew tap Homebrew/bundle

brew/%:
	brew $(@F)

vscode: json_dir := $(HOME)/Library/Application\ Support/Code/User
vscode: $(VSCODE) $(VSCODE_EXTENSIONS)
	@find $(json_dir) -maxdepth 1 -type f -name 'settings.json' -o -name 'keybindings.json' | xargs rm -f
	@ln -sf $(CURDIR)/.vscode/settings.json $(json_dir)/settings.json
	@ln -sf $(CURDIR)/.vscode/keybindings.json $(json_dir)/keybindings.json
	# for vscodevim.vim extension: https://github.com/VSCodeVim/Vim#-installation
	-defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
	-defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false
	-defaults delete -g ApplePressAndHoldEnabled

$(VSCODE): $(BREW)
	which $@ 2>/dev/null || brew cask install visual-studio-code
	@mkdir -p ~/.vscode/extensions

# Extensions name is defined by itemName of URI
# e.g.)  (hoge.hoge) https://marketplace.visualstudio.com/items?itemName=hoge.hoge
$(VSCODE_EXTENSIONS): installed_lists = $(shell code --list-extensions)
$(VSCODE_EXTENSIONS): $(VSCODE)
	$(if $(filter $@,$(installed_lists)),, $< --install-extension $@)
