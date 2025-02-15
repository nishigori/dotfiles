-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function keymap(modes, lhs, rhs, opts)
  if type(modes) ~= "table" then
    modes = { modes }
  end

  for _, mode in ipairs(modes) do
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
  end
end

local silent = { noremap = true, silent = true }

keymap("n", "<Tab>", "<cmd>bnext<CR>", silent)
keymap("n", "<S-Tab>", "<cmd>bprevious<CR>", silent)

-- ; <-> :
keymap({ "n", "o", "x", "v" }, ";", ":", { noremap = true })
keymap({ "n", "o", "x", "v" }, ":", ";", { noremap = true })
keymap({ "n", "v" }, "q;", "q:", silent)

-- Copy & Paste
keymap("v", "<C-c>", '"+y', silent)
keymap("v", "<M-c>", '"+y', silent)
keymap("v", "<D-c>", '"+y', silent)
keymap("v", "<C-v>", 'd"+P', silent)
keymap("c", "<C-v>", "<C-R>+", silent)
keymap("v", "<C-v>", '<ESC>"+pa', silent)

-- Moving Cursor
keymap({ "n", "o", "x" }, "j", "gj", silent)
keymap({ "n", "o", "x" }, "k", "gk", silent)
-- Moving Cursor (Bash like)
keymap("v", "<C-a>", "<C-o>0", silent)
keymap("i", "<C-e>", "<C-o>$", silent)
keymap("c", "<C-a>", "<Home>", silent)
keymap("c", "<C-e>", "<End>", silent)
keymap({ "i", "c" }, "<C-b>", "<Left>", silent)
keymap({ "i", "c" }, "<C-f>", "<Right>", silent)
keymap({ "i", "c" }, "<C-d>", "<Delete>", silent)

-- Save buffer
-- TODO: LazyVim 側が何かマッピングしていなければ再び有効に
--keymap("i", "<c-s>", "<esc><cmd>w<cr>a", silent)

if vim.g.vscode then
  keymap("n", ":", "<Cmd>call VSCodeNotify('workbench.view.explorer')<CR>", silent)

  return -- End of vscode
end

-- Abobe lines for without vscode

keymap("n", "<Leader>ba", "<cmd>b#<CR>", {
  noremap = true,
  silent = true,
  desc = "Open previous buffer",
})

-- Disabled old keymap cause broken `vnoremap :`
--keymap("n", ":", "<Leader>e", { noremap = false, silent = true })
