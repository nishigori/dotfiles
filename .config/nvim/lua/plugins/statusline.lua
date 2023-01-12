return {

  {
    "nvim-lualine/lualine.nvim",
    event = {
      "InsertEnter",
      "CursorHold",
      "FocusLost",
      "BufRead",
      "BufNewFile",
    },
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
    init = function()
      vim.opt.laststatus = 0
      vim.opt.showtabline = 0
    end,
    config = function()
      local icons = require("icons").diagnostics

      require("lualine").setup {

        extensions = {
          'aerial',
          'quickfix',
        },

        options = {
          icons_enabled = true,
          theme = "auto",
          globalstatus = true,
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "|" },
          disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha", "NvimTree" } },
          refresh = {
            winbar = 600,
            statusline = 2000,
          },
        },

        sections = {
          lualine_a = { [[""]] },
          lualine_b = {
            {
              "diagnostics",
              sources = { "nvim_lsp", "nvim_diagnostic" },
              sections = { "error", "warn", "info", "hint" },
              colored = true,
              update_in_insert = false,
              always_visible = true,
              diagnostics_color = {
                -- Same values as the general color option can be used here.
                error = "DiagnosticError", -- Changes diagnostics' error color.
                warn  = "DiagnosticWarn",  -- Changes diagnostics' warn color.
                info  = "DiagnosticInfo",  -- Changes diagnostics' info color.
                hint  = "DiagnosticHint",  -- Changes diagnostics' hint color.
              },
            },
          },
          lualine_c = {
            -- Show git project of git
            [[vim.fn.fnamemodify(vim.fn.finddir(".git/..", ".;"), ":t")]],
            -- The relative path under the git-root
            function()
              return string.gsub(
                vim.api.nvim_buf_get_name(0),
                vim.fn.fnamemodify(vim.fn.finddir(".git/..", ".;"), ":p"), --vim.loop.cwd(),
                '')
            end,
          },

          lualine_x = { "branch", "diff" },
          lualine_y = {
            { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = { fg = "#ff9e64" } },
          },
          lualine_z = {},
        },

      }

      vim.api.nvim_create_autocmd('WinLeave', {
        pattern = { 'NvimTree', },
        callback = function ()
          require('lualine').refresh({
            scope = 'all',
            place = 'winbar',
          })
        end,
      })
    end,
  },

}
