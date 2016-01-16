#!/bin/zsh
# -*- mode: zsh -*-
# vim:ft=zsh
#
# *** ZPLUG EXTERNAL FILE ***
# You can register plugins or commands to zplug on the
# command-line. If you use zplug on the command-line,
# it is possible to write more easily its settings
# by grace of the command-line completion.
# In this case, zplug spit out its settings to
# /Users/t-nishigori/.zplug/init.zsh instead of .zshrc.
# If you launch new zsh process, zplug load command
# automatically search this file and run source command.
#
#
# Example:
# zplug "b4b4r07/enhancd", as:plugin, of:"*.zsh"
# zplug "rupa/z",          as:plugin, of:"*.sh"
#
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"

zplug "mollifier/anyframe"

# junegunn/dotfiles にある bin の中の vimcat をコマンドとして管理する
zplug "junegunn/dotfiles", as:command, of:bin/vimcat

zplug "k4rthik/git-cal", as:command, frozen:1
zplug "plugins/git", from:oh-my-zsh

zplug "plugins/python", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/virtualenv", from:oh-my-zsh
zplug "plugins/virtualenvwrapper", from:oh-my-zsh

zplug "plugins/ruby", from:oh-my-zsh
zplug "plugins/rbenv", from:oh-my-zsh
zplug "plugins/gem", from:oh-my-zsh
zplug "plugins/bundler", from:oh-my-zsh

zplug "plugins/node", from:oh-my-zsh
zplug "plugins/npm", from:oh-my-zsh
zplug "plugins/composer", from:oh-my-zsh

zplug "plugins/aws", from:oh-my-zsh

zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "tcnksm/docker-alias", of:zshrc, as:plugin

# TODO: why source cannot read?
#zplug "mitchellh/packer", of:"contrib/zsh-completions/_packer"
#zplug "docker/docker", of:"contrib/completion/zsh/_docker"

# Themes
zplug "themes/bira", from:oh-my-zsh
zplug "themes/bureau", from:oh-my-zsh

# NOTE: If you're static on OS, delete comment-out
## case ${OSTYPE} in
##     darwin*)
           zplug "plugins/osx", from:oh-my-zsh
           zplug "plugins/brew", from:oh-my-zsh
           zplug "plugins/brew-cask", from:oh-my-zsh
           zplug "plugins/tmux", from:oh-my-zsh
##         ;;
##     freebsd*)
##         ;;
##     linux*)
##         zgen oh-my-zsh plugins/gnu-utils
##         if [ -f /etc/redhat-release ]; then
##             zgen oh-my-zsh plugins/yum
##         elif [ -f /etc/debian_version ]; then
##             zgen oh-my-zsh plugins/debian
##         fi
##         ;;
## esac

