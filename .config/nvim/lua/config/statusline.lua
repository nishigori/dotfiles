local lualine = require 'lualine'

lualine.setup {
  icons_enabled = true,
  theme = "papercolor_dark", -- "auto", ...

  disabled_filetypes = {
    statusline = {"packer", "NVimTree"}
  },

  tabline = {
    lualine_a = {
      -- Show git project of git
      function() return vim.fn.fnamemodify(vim.fn.finddir(".git/..", ".;"), ":t") end,
    },
    lualine_b = {
      -- The relative path under the git-root
      function()
        return string.gsub(
          vim.api.nvim_buf_get_name(0),
          vim.fn.fnamemodify(vim.fn.finddir(".git/..", ".;"), ":p"), --vim.loop.cwd(),
          '')
      end,
    },
    lualine_c = {},

    lualine_x = {
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
    lualine_y = {"branch", "diff"},
    lualine_z = {
      function() return [[]] end,
      "mode",
    },
  },

  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },

  options = {
    globalstatus = true,
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "|" },
  },
}
