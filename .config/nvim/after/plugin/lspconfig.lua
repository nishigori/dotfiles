-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion

require 'mason'
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  automatic_installation = true,
  -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
  -- NOTE: different names between of `:Mason`, check `:LspInfo`
  ensure_installed = {
    --"actionlint", -- github actions
    "bashls",
    "bufls", -- probuf
    "dockerls",
    "erlangls",
    "gopls",
    "perlnavigator",
    "sumneko_lua", -- lua-language-server
    "terraformls",
    "tflint",
    "tsserver",
    "yamlls",
  }
}

local null_ls = require 'null-ls'
local mason_null_ls = require 'mason-null-ls'

-- vim辞書がなければダウンロード
if vim.fn.filereadable("~/.local/share/cspell/vim.txt.gz") ~= 1 then
  io.popen("curl -fsSLo ~/.local/share/cspell/vim.txt.gz --create-dirs "
  .. "https://github.com/iamcco/coc-spell-checker/raw/master/dicts/vim/vim.txt.gz")
end
if vim.fn.filereadable("~/.config/cspell/user.txt") ~= 1 then
  io.popen("mkdir -p ~/.config/cspell")
  io.popen("touch ~/.config/cspell/user.txt")
end

null_ls.setup {
  sources = {
    null_ls.builtins.diagnostics.cspell.with({
      extra_args = { "--config", "~/.config/cspell/cspell.json" },
      diagnostics_postprocess = function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity["WARN"] -- default "ERROR"
      end,
      condition = function() return vim.fn.executable('cspell') > 0 end,
    })
  },
}

mason_null_ls.setup {
  automatic_setup = true,
  -- https://github.com/jayp0521/mason-null-ls.nvim#available-null-ls-sources
  ensure_installed = {
    "buildifier", -- bzl
    "cspell",     -- spell checker
    "hadolint",   -- dockerfile
    "goimports",  -- go
    "stylua",     -- lua
    "buf",        -- protobuf
    "psalm",      -- php
    "jq",         -- json
  }
}
local trouble = require 'trouble'

trouble.setup {
  fold_open = "",
  fold_closed = "",
}

-- UI: light-weight lsp
-- TOOD: diagnostic 自動表示、lspsagaで表示してリッチにしたい
local saga = require 'lspsaga'
saga.init_lsp_saga({
  -- TODO: configuration
})


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

-- https://xbgneb0083.hatenablog.com/entry/2022_6_12_avoid_conflict_lsp_hover
local function on_cursor_hold()
  if vim.lsp.buf.server_ready() then
    vim.diagnostic.open_float()
  end
end

local diagnostic_hover_augroup_name = "lspconfig-diagnostic"

local function enable_diagnostics_hover()
  vim.api.nvim_create_augroup(diagnostic_hover_augroup_name, { clear = true })
  vim.api.nvim_create_autocmd({ "CursorHold" }, { group = diagnostic_hover_augroup_name, callback = on_cursor_hold })
end

local function disable_diagnostics_hover()
  vim.api.nvim_clear_autocmds({ group = diagnostic_hover_augroup_name })
end

vim.api.nvim_set_option('updatetime', 350)
enable_diagnostics_hover()

local function on_hover()
  disable_diagnostics_hover()

  require('lspsaga.hover'):render_hover_doc()

  vim.api.nvim_create_augroup("lspconfig-enable-diagnostics-hover", { clear = true })
  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { group = "lspconfig-enable-diagnostics-hover", callback = function()
    vim.api.nvim_clear_autocmds({ group = "lspconfig-enable-diagnostics-hover" })
    enable_diagnostics_hover()
  end })
end

vim.keymap.set('n', '<Leader>lk', on_hover, opt)
