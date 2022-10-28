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
keymap('n', '<Leader>a', ':<C-u>b#<CR>', opts) -- Open previous buffer
keymap('n', '<Leader>d', ':<C-u>bd<CR>', opts) -- Close current buffer
keymap('n', '<Leader>o', '<Plug>(openbrowser-smart-search)', { noremap = false })

-- https://github.com/mgraczyk/neovim/commit/ac2b770c25c234ee3feb8e2c9fc5a5ba2ae65592
--vim.cmd([[set <D-a>={CSI sequence}]])

local telescope = require('telescope.builtin')
-- TODO: Enable <D-..> key (mac command)
--       https://github.com/neovim/neovim/issues/2190
vim.keymap.set('n', '<d-a>', telescope.builtin)
vim.keymap.set('n', '<d-s-a>', telescope.builtin)
--keymap('n', '<d-s-a>', ':Telescope builtin<CR>', opts)
keymap('n', ',,', ':Telescope builtin<CR>', opts)
keymap('n', 'q;', ':Telescope command_history theme=get_ivy<CR>', opts)
vim.keymap.set('n', ',f', function() telescope.find_files({hidden=true}) end, {})
vim.keymap.set('n', ',g', telescope.live_grep, {})
vim.keymap.set('n', '<C-l>', telescope.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<C-p>', telescope.oldfiles, {})
vim.keymap.set('n', '<C-n>', telescope.buffers, {})
--vim.keymap.set('n', '<C-g>', ..., {})
-- Shift+command+A で actionをば
-- Shift+command+N で Go to file... をば
