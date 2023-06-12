local m = {
  { -- % で block jump をもっと高性能に
    "andymass/vim-matchup",
    event = "User ActuallyEditing",
    init = function()
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_deferred_show_delay = 100
      vim.g.matchup_matchparen_hi_surround_always = 1
      vim.g.matchup_override_vimtex = 1
      vim.g.matchup_delim_start_plaintext = 0
      vim.g.matchup_transmute_enabled = 0
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = {
      fast_wrap = {
        chars = { "{", "[", "(", '"', "'" },
      }
    },
  },
}

if not vim.g.vscode then
  local m2 = {
    -- comments
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    {
      "echasnovski/mini.comment",
      event = "VeryLazy",
      opts = {
        hooks = {
          pre = function() require("ts_context_commentstring.internal").update_commentstring({}) end,
        },
      },
      config = function (_, opts)
        require("mini.comment").setup(opts)
      end
    },

    -- snippets
    {
      "L3MON4D3/LuaSnip",
      dependencies = {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      opts = {
        history = true,
        delete_check_events = "TextChanged",
        region_check_events = 'InsertEnter',
      },
      -- stylua: ignore
      keys = {
        {
          "<tab>",
          function()
            return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
          end,
          expr = true, remap = true, silent = true, mode = "i",
        },
        { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
        { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
      },
    },

    -- auto completion
    {
      "hrsh7th/nvim-cmp",
      event = { "InsertEnter", "CmdlineEnter" },
      dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "petertriho/cmp-git",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lua",
        "saadparwaiz1/cmp_luasnip",
        "lukas-reineke/cmp-under-comparator",
        "onsails/lspkind.nvim",
      },
      config = function()
        local cmp = require 'cmp'

        cmp.setup {
          completion = { completeopt = 'menu,menuone,noinsert' },
          snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-l>'] = cmp.mapping.complete({''}),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ['<C-;>'] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
            ['<C-e>'] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
            ['<cr>'] = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace },
          }),
          sources = {
            { name = 'nvim_lsp', keyword_length = 2 },
            { name = 'nvim_lsp_signature_help' },
            { name = 'luasnip', keyword_length = 2 },
            { name = 'nvim_lua' },
            { name = 'path' },
            { name = 'buffer', keyword_length = 3 },
            { name = 'git' },
          },
          formatting = {
            format = function(entry, vim_item)
              local kind = require('lspkind').cmp_format { mode = 'symbol_text', maxwidth = 50 }(entry, vim_item)
              local strings = vim.split(kind.kind, '%s', { trimempty = true })
              kind.kind = ' ' .. strings[1] .. ' '
              kind.menu = '    (' .. strings[2] .. ')'
              return kind
            end
          },
          window = {
            documentation = cmp.config.window.bordered(),
          },
          sorting = {
            comparators = {
              cmp.config.compare.offset,
              cmp.config.compare.exact,
              cmp.config.compare.score,
              require "cmp-under-comparator".under,
              cmp.config.compare.kind,
              cmp.config.compare.sort_text,
              cmp.config.compare.length,
              cmp.config.compare.order,
            },
          },
          experimental = {
            ghost_text = false,
          },
        }

        cmp.setup.cmdline('/', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = { { name = 'buffer' } },
        })

        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          source = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
        })
        cmp.setup.cmdline(';', {
          mapping = cmp.mapping.preset.cmdline(),
          source = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
        })
      end,
    },
    {
      "rcarriga/cmp-dap",
      event = "InsertEnter",
      dependencies = { "hrsh7th/nvim-cmp", "rcarriga/nvim-dap-ui" },
    },

    -- copilot
    {
      "zbirenbaum/copilot.lua",
      enabled = false, -- TODO: enabled buy github copilot
      event = "InsertEnter",
      config = function ()
        vim.schedule(function()
          require("copilot").setup {
            copilot_node_command = 'node', -- Node version must be < 18
          }
        end)
      end,
    },
  }

  for k,v in pairs(m2) do m[k] = v end
end

return m
