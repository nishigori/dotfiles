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
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
--opt.lazyredraw = true
opt.shada = "!,'2500,<50,s10,h" -- :h viminfo
opt.clipboard = "unnamedplus"
opt.splitbelow = true
opt.splitright = true
opt.cmdheight = 0 -- Using noice.nvim is popup command
opt.showcmd = false
opt.completeopt = { "menuone", "noselect" }
opt.conceallevel = 0
opt.hlsearch = true
opt.ignorecase = true
opt.mouse = "a"
opt.smartcase = true
opt.autoindent = true
opt.smartindent = true
opt.undofile = true
opt.shell = "zsh"
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.hidden = true
opt.guicursor = [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]]
opt.guifont = "Fira Code Nerd Font Mono:h16" -- "Hack Nerd Font:h16"
opt.termguicolors = true
opt.list = true
opt.scrolloff = 3
opt.wildignore = { '*.o', '*~', '*.pyc' }

opt.shortmess:append("c")
opt.listchars:append "space:⋅"
opt.listchars:append "eol:↴"

-- Needs using Tree-sitter
local o = vim.o
o.foldcolumn = "3"
o.foldlevel = 99 -- large value depends by nvim-ufo
o.foldlevelstart = 99
o.foldenable = true
o.foldexpr = "nvim_treesitter#foldexpr()"
o.laststatus = 0 -- For lualine.nvim

-- TODO: really need?
--local cmd = vim.cmd
--cmd([[set grepprg=rg\ --vimgrep]])
--cmd([[set grepformat=%f:%l:%c:%m]])

-- Plugins
if vim.fn.exists("g:vscode") ~= 1 then
  require('plugins')
  require('lspconfig')
  vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]
end

-- KeyMap
g.mapleader = " "
require('keymaps')
