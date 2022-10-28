vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 0

-- TODO: write in lspconfig.lua?
--require("lspconfig").terraformls.setup{}
--vim.api.nvim_create_autocmd({"BufWritePre"}, {
--  pattern = {"*.tf", "*.tfvars"},
--  callback = vim.lsp.buf.format,
--})
