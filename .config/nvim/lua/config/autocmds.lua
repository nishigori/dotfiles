-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "snacks_picker_input" },
  callback = function()
    vim.b.minipairs_disable = true
  end,
})

--vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
--  --pattern = { "snacks_picker_input" },
--  callback = function(args)
--    local bufnr = args.buf
--    if vim.api.nvim_buf_line_count(bufnr) > 80 then
--      local aerial = require("aerial")
--      aerial.open()
--    end
--  end,
--})
