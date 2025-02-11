local silent = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

keymap('n', ';', ':', { noremap = true })
keymap('n', ':', ';', { noremap = true })
keymap('v', ';', ':', { noremap = true })
keymap('v', ':', ';', { noremap = true })
keymap('o', ';', ':', { noremap = true })
keymap('o', ':', ';', { noremap = true })
keymap('x', ';', ':', { noremap = true })
keymap('x', ':', ';', { noremap = true })

keymap('n', 'q;', 'q:', silent)
keymap('v', 'q;', 'q:', silent)

keymap('i', '<c-w>', '<esc>ciw', silent)
keymap('n', 'cw', 'ciw', silent)
keymap('n', 'dw', 'diw', silent)

-- Search cursor words
keymap('n', '*', '*N', silent)

-- Copy
keymap('v', '<C-c>', '"+y', silent)
keymap('v', '<M-c>', '"+y', silent)
keymap('v', '<D-c>', '"+y', silent)

-- Paste
keymap('v', '<C-v>', 'd"+P', silent)
keymap('c', '<C-v>', '<C-R>+', silent)
keymap('v', '<C-v>', '<ESC>"+pa', silent)

-- Moving Cursor
keymap('n', 'j', 'gj', silent)
keymap('o', 'j', 'gj', silent)
keymap('x', 'j', 'gj', silent)
keymap('n', 'k', 'gk', silent)
keymap('o', 'k', 'gk', silent)
keymap('x', 'k', 'gk', silent)
-- Bash like
keymap('v', '<C-a>', '<C-o>0', silent)
keymap('i', '<C-e>', '<C-o>$', silent)
keymap('i', '<C-b>', '<Left>', silent)
keymap('i', '<C-f>', '<Right>', silent)
keymap('i', '<C-d>', '<Delete>', silent)
keymap('c', '<C-a>', '<Home>', silent)
keymap('c', '<C-e>', '<End>', silent)
keymap('c', '<C-b>', '<Left>', silent)
keymap('c', '<C-f>', '<Right>', silent)
keymap('c', '<C-d>', '<Delete>', silent)

-- Save buffer
keymap('i', '<c-s>', '<esc><cmd>w<cr>a', silent)

-- Explorer
if vim.g.vscode then
  keymap('n', ':', "<Cmd>call VSCodeNotify('workbench.view.explorer')<CR>", silent)
else
  -- TODO: on keys in plugins/ui_explorer.nvim
  keymap('n', ':', ':Neotree toggle reveal<CR>', silent)
end

-- Translate
-- FIXME: conflict vscode `refactoring`
keymap('x', '<C-t>', '<cmd>Translate JA<CR>', silent)
-- FIXME: conflict wezterm `new tab`
keymap('x', '<C-S-t>', '<cmd>Translate EN<CR>', silent)

-- Remove default of plugins
--vim.keymap.del("n", "<Leader>d")

if not vim.g.vscode then
  keymap('n', '<Leader>a', '<cmd>b#<CR>', {
    noremap = true,
    silent = true,
    desc = "Open previous buffer",
  })

  -- Shift+command+A で actionをば

  -- TODO: Delete after migrated snacks.nvim
  -- <Leader>w\w+ is send from wezterm keys
  --keymap('n', '<Leader>w-rc', '<cmd>Telescope builtin<CR>', silent) -- TODO: たぶん builtin よりもっと適切なコマンドあるはず (maybe lsp_*)
  --keymap('n', '<Leader>w-ra', '<cmd>Lspsaga code_action<CR>', silent)
  --keymap('n', '<Leader>wo', '<cmd>Telescope git_files<CR>', silent)
  --keymap('n', '<Leader>wa', '<cmd>Telescope builtin theme=get_dropdown<CR>', silent)
  --keymap('n', '<Leader>wl', '<cmd>Telescope current_buffer_fuzzy_find<CR>', silent)
  --keymap('n', '<Leader>we', '<cmd>Telescope oldfiles only_cwd=true<CR>', silent)
  --keymap('n', '<Leader>w1', '<cmd>NvimTreeFindFile!<CR>', silent)
  --keymap('n', '<Leader>w6', '<cmd>TroubleToggle<CR>', silent)
  --keymap('n', '<Leader>w7', '<cmd>AerialToggle! right<CR>', silent)
  --keymap('n', '<Leader>wr', '<cmd>Lspsaga rename<CR>', silent)
end
