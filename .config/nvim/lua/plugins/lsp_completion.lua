if vim.g.vscode then
  return {}
end

return {

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

  { -- Debugger
    "rcarriga/nvim-dap-ui",
    event = { "BufRead", "BufNewFile" },
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = true,
  },

}
