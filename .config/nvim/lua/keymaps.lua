local silent = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

keymap('n', ';', ':', { noremap = true })
keymap('n', ':', ';', { noremap = true })
keymap('v', ';', ':', { noremap = true })
keymap('v', ':', ';', { noremap = true })

-- Always disabled IME?
--keymap('i', '<Esc>', '<ESC>:set iminsert=0<CR>', silent)
--keymap('i', '<C-]>', '<ESC>:set iminsert=0<CR>', silent)

keymap('n', 'q;', 'q:', silent)
keymap('v', 'q;', 'q:', silent)

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
keymap('n', ':', ':Neotree toggle reveal<CR>', silent)
keymap('n', '<C-t>', '<cmd>ToggleTerm<CR>', silent)
-- Translate
keymap('x', '<C-t>', '<cmd>Translate JA<CR>', silent)
-- FIXME: conflict wezterm `new tab`
keymap('x', '<C-S-t>', '<cmd>Translate EN<CR>', silent)

keymap('n', 'q;', '<cmd>Telescope command_history theme=get_ivy<CR>', silent)
keymap('n', ',f', '<cmd>TransparentToggle<CR>', silent)
keymap('n', ',g', '<cmd>Telescope live_grep<CR>', silent)
keymap('n', '<C-p>', '<cmd>Telescope oldfiles<CR>', silent)
keymap('n', '<C-n>', '<cmd>Telescope buffers<CR>', silent)
--keymap('n', '<C-g>', ..., silent)
-- Shift+command+A で actionをば

-- <Leader>
keymap('n', '<Leader>a', '<cmd>b#<CR>', silent) -- Open previous buffer
--keymap('n', '<Leader>d', '<cmd>bd<CR>', silent) -- Close current buffer (override from mini.bufremove)
keymap('n', '<Leader>o', '<Plug>(openbrowser-smart-search)', { noremap = false })
keymap('n', '<leader>t', '<cmd>Translate JA<CR>', silent)
-- <Leader>w\w+ is send from wezterm keys
keymap('n', '<Leader>w-rc', '<cmd>Telescope builtin<CR>', silent) -- TODO: たぶん builtin よりもっと適切なコマンドあるはず (maybe lsp_*)
keymap('n', '<Leader>w-ra', '<cmd>Lspsaga code_action<CR>', silent)
keymap('n', '<Leader>wn', '<cmd>Telescope git_files<CR>', silent)
keymap('n', '<Leader>wa', '<cmd>Telescope builtin theme=get_dropdown<CR>', silent)
keymap('n', '<Leader>wl', '<cmd>Telescope current_buffer_fuzzy_find<CR>', silent)
keymap('n', '<Leader>we', '<cmd>Telescope oldfiles only_cwd=true<CR>', silent)
keymap('n', '<Leader>w1', '<cmd>NvimTreeFindFile!<CR>', silent)
keymap('n', '<Leader>w6', '<cmd>TroubleToggle<CR>', silent)
keymap('n', '<Leader>w7', '<cmd>AerialToggle! right<CR>', silent)
keymap('n', '<Leader>wr', '<cmd>Lspsaga rename<CR>', silent)
