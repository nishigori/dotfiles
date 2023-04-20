return {

  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
  },

  {
    "williamboman/mason-lspconfig.nvim",
    event = "BufReadPre",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "jayp0521/mason-null-ls.nvim",
      "ray-x/lsp_signature.nvim", -- show function signature when you type
      "hrsh7th/cmp-nvim-lsp",
    },
  },

  { -- lsp: ui
    "glepnir/lspsaga.nvim",
    cmd = "Lspsaga",
    event = "BufReadPre",
    dependencies = "williamboman/mason-lspconfig.nvim",
    opts = {
      -- TODO: diagnostic 自動表示、lspsagaで表示してリッチにしたい
      symbol_in_winbar = {
        enable = true,
        separator = '  ',
        --file_formatter = "%:h", -- same as arg1 of vim.vn.expand
        -- TODO: 変数名までは出したくない
      },
      code_action_lightbulb = { enable = true },
    },
    config = function()
      -- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
      -- https://gist.github.com/VonHeikemen/8fc2aa6da030757a5612393d0ae060bd

      local mason = require 'mason'
      local mason_lspconfig = require 'mason-lspconfig'

      mason.setup()
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

      mason_null_ls.setup {
        automatic_installation = true,
        -- https://github.com/jayp0521/mason-null-ls.nvim#available-null-ls-sources
        ensure_installed = {
          "buildifier",   -- bzl
          "cspell",       -- spell checker
          "hadolint",     -- dockerfile
          "goimports",    -- go
          "staticcheck",  -- go
          "stylua",       -- lua
          "buf",          -- protobuf
          --"psalm",        -- php
          "jq",           -- json
        },
        handlers = {
          function() end, -- disables automatic setup of all null-ls sources
          function (source_name, methods)
            -- all sources with no handler get passed here
            -- Keep original functionality of `automatic_setup = true`
            require('mason-null-ls.automatic_setup')(source_name, methods)
          end,
          cspell = function (_, _)
            -- download vim official dictionary
            if vim.fn.filereadable("~/.local/share/cspell/vim.txt.gz") ~= 1 then
              io.popen("curl -fsSLo ~/.local/share/cspell/vim.txt.gz --create-dirs "
                .. "https://github.com/iamcco/coc-spell-checker/raw/master/dicts/vim/vim.txt.gz")
            end
            if vim.fn.filereadable("~/.config/cspell/user.txt") ~= 1 then
              io.popen("mkdir -p ~/.config/cspell")
              io.popen("touch ~/.config/cspell/user.txt")
            end
            null_ls.register(null_ls.builtins.diagnostics.cspell.with({
              extra_args = { "--config", "~/.config/cspell/cspell.json" },
              diagnostics_postprocess = function(diagnostic)
                diagnostic.severity = vim.diagnostic.severity["WARN"] -- default "ERROR"
              end,
              condition = function() return vim.fn.executable('cspell') > 0 end,
            }))
          end,
        }
      }

      -- will setup any installed and configured sources above
      null_ls.setup()

      -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- nvim-ufo
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }

      local lspconfig = require 'lspconfig'
      local lsp_defaults = lspconfig.util.default_config
      local lsp_signature = require 'lsp_signature'

      lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      -- :h mason-lspconfig-automatic-server-setup
      mason_lspconfig.setup_handlers {
        function (server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            capabilities = lsp_defaults.capabilities, --cmpを連携
            on_attach = function(client, bufnr)
              --if client.server_capabilities.documentSymbolProvider then
              --  TODO: change lsp saga
              --  navic.attach(client, bufnr)
              --end

              lsp_signature.on_attach({
                noice = true,
                transparency = 15,
                bind = true, -- This is mandatory, otherwise border config won't get registered.
                handler_opts = {
                  border = "rounded"
                }
              }, bufnr)
            end,
          }
        end,
        ["sumneko_lua"] = function (_)
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
          lspconfig.sumneko_lua.setup {
            settings = {
              Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = {"vim"} },
                telemetry = { enable = false },
                workspace = { check_third_party = false },
              }
            }
          }
          lspconfig.yamlls.setup {
            settings = {
              yaml = {
                schemas = {
                  ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
                },
              }
            }
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

      --vim.keymap.set('n', '<Leader>lk', on_hover, opt)
      local set = vim.keymap.set
      --set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
      --set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
      --set("n", "<C-m>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
      --set("n", "rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
      --set("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
      --set("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
      set("n", "<S-k>", "<cmd>Lspsaga hover_doc<CR>")
      set("n", "gd", "<cmd>Lspsaga peek_definition<CR>")
      set("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
      set("n", "ma", "<cmd>lua vim.lsp.buf.code_action()<CR>")
      set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
      set("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
    end,
  },

}
