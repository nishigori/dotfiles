local options = {
  encoding = "utf-8",
  fileencoding = "utf-8",
  clipboard = "unnamedplus",
  cmdheight = 2,
  completeopt = { "menuone", "noselect" },
  conceallevel = 0,
  hlsearch = true,
  ignorecase = true,
  mouse = "a",
  smartcase = true,
  smartindent = true,
  undofile = true,
  shell = "zsh",
  cursorline = true,
  number = true,
  relativenumber = true,
  guifont = "Hack Nerd Font:h16",
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.g.mapleader = " "

require('plugins')
vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]

require('keymaps')

vim.cmd([[set grepprg=rg\ --vimgrep]])
vim.cmd([[set grepformat=%f:%l:%c:%m]])
