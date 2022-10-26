local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

keymap('n', ';', ':', { noremap = true })
keymap('n', ':', ';', { noremap = true })
keymap('v', ';', ':', { noremap = true })

keymap('n', 'q;', 'q:', opts)
keymap('v', 'q;', 'q:', opts)

-- Search cursor words
keymap('n', '*', '*N', opts)

-- Copy
keymap('v', '<C-c>', '"+y', opts)
keymap('v', '<M-c>', '"+y', opts)
keymap('v', '<D-c>', '"+y', opts)

-- Paste
keymap('v', '<C-v>', 'd"+P', opts)
keymap('c', '<C-v>', '<C-R>+', opts)
keymap('v', '<C-v>', '<ESC>"+pa', opts)

-- Moving Cursor
keymap('n', 'j', 'gj', opts)
keymap('o', 'j', 'gj', opts)
keymap('x', 'j', 'gj', opts)
keymap('n', 'k', 'gk', opts)
keymap('o', 'k', 'gk', opts)
keymap('x', 'k', 'gk', opts)
-- Bash like
keymap('v', '<C-a>', '<C-o>0', opts)
keymap('i', '<C-e>', '<C-o>$', opts)
keymap('i', '<C-b>', '<Left>', opts)
keymap('i', '<C-f>', '<Right>', opts)
keymap('i', '<C-d>', '<Delete>', opts)
keymap('c', '<C-a>', '<Home>', opts)
keymap('c', '<C-e>', '<End>', opts)
keymap('c', '<C-b>', '<Left>', opts)
keymap('c', '<C-f>', '<Right>', opts)
keymap('c', '<C-d>', '<Delete>', opts)

-- <Leader>
keymap('n', '<Leader>o', '<Plug>(openbrowser-smart-search)', { noremap = false })

local telescope = require('telescope.builtin')
vim.keymap.set('n', 'ef', telescope.find_files, {})
vim.keymap.set('n', '<C-n>', telescope.buffers, {})
