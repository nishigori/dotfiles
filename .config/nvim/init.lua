MY_SECRETS = require("secrets")

local options = {
  encoding = "utf-8",
  fileencoding = "utf-8",
  shada = "!,'2500,<50,s10,h", -- :h viminfo
  clipboard = "unnamedplus",
  cmdheight = 0,
  showcmd = false,
  completeopt = { "menuone", "noselect" },
  conceallevel = 0,
  hlsearch = true,
  ignorecase = true,
  mouse = "a",
  smartcase = true,
  autoindent = true,
  smartindent = true,
  undofile = true,
  shell = "zsh",
  cursorline = true,
  number = true,
  relativenumber = true,
  guifont = "Fira Code Nerd Font Mono:h16", -- "Hack Nerd Font:h16"
  termguicolors = true,
  list = true,
  scrolloff = 3,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append("c")
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

vim.cmd([[set grepprg=rg\ --vimgrep]])
vim.cmd([[set grepformat=%f:%l:%c:%m]])
require('plugins')
vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]

-- Tree-sitter
vim.o.foldcolumn = "3"
vim.o.foldlevel = 99 -- large value depends by nvim-ufo
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

-- Terraform
-- TODO: move to filetype.lua ?
vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])

vim.g.mapleader = " "
require('keymaps')
