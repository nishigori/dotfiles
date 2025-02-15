-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.maplocalleader = ","

vim.g.MY_SECRETS = require("config.secrets")

vim.opt.guifont = { "Hack Nerd Font:h19" } -- "Fira Code Nerd Font Mono:h16"
vim.opt.guifontwide = { "Hack Nerd Font:h19" } -- "Fira Code Nerd Font Mono:h16"
