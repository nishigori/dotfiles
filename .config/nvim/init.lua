MY_SECRETS = require "secrets"

local g = vim.g

-- Disabled some built-in plugins don't want
g["loaded_gzip"] = 1
g["loaded_man"] = 1
g["loaded_matchit"] = 1
g["loaded_matchparen"] = 1
g["loaded_shada_plugin"] = 1
g["loaded_tarPlugin"] = 1
g["loaded_tar"] = 1
g["loaded_zipPlugin"] = 1
g["loaded_zip"] = 1
g["loaded_netrwPlugin"] = 1

-- Settings
local opt = vim.opt
--opt.lazyredraw = true
opt.shada = "!,'2500,<50,s10,h" -- :h viminfo
opt.clipboard = "unnamedplus"
opt.splitbelow = true
opt.splitright = true
opt.ruler = false
opt.conceallevel = 0
opt.hlsearch = true
opt.ignorecase = true
opt.mouse = "a"
opt.smartcase = true
opt.autoindent = true
opt.smartindent = true
opt.undofile = true
opt.hidden = true
opt.guifont = {"Hack Nerd Font:h19"} -- "Fira Code Nerd Font Mono:h16"
opt.guifontwide = {"Hack Nerd Font:h19"} -- "Fira Code Nerd Font Mono:h16"
opt.list = true
opt.wrapscan = false
opt.wildignore = { '*.o', '*~', '*.pyc' }
opt.inccommand = "nosplit"
opt.sidescrolloff = 6
opt.cmdheight = 0 -- Using noice.nvim is popup command
opt.showcmd = false
opt.signcolumn = "yes" -- always display diagnostic

if not vim.g.vscode then
  opt.encoding = "utf-8"
  opt.fileencoding = "utf-8"
  opt.shell = "zsh"
  opt.number = true
  opt.relativenumber = true
  opt.shiftwidth = 2
  opt.scrolloff = 5
  opt.cursorline = true
  opt.guicursor = [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]]
  opt.completeopt = { "menuone", "noselect" }
  opt.termguicolors = true
  opt.shortmess:append("cI")
  opt.listchars:append "trail:⋅"
  --opt.listchars:append "eol:↴"
  g.nvcode_termcolors = 256

  -- TODO: really need?
  --local cmd = vim.cmd
  --cmd([[set grepprg=rg\ --vimgrep]])
  --cmd([[set grepformat=%f:%l:%c:%m]])
end

g.mapleader = " "

-- Plugins
-- https://github.com/folke/lazy.nvim#-installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- KeyMap
require('keymaps')
