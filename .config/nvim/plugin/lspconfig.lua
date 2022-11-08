-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion

local navic = require("nvim-navic")
local on_attach = function(client, bufnr)

  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  local set = vim.keymap.set
  set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  set("n", "<C-m>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  set("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
  set("n", "rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  set("n", "ma", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  set("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
  set("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
  set("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
end

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- nvim-ufo
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
require("lspconfig").sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = {"vim"} },
      telemetry = { enable = false },
    }
  }
}

require("mason-lspconfig").setup_handlers {
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
      on_attach = on_attach, --keyバインドなどの設定を登録
      capabilities = capabilities, --cmpを連携
    }
  end,
}
