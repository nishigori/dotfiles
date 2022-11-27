local lualine = require 'lualine'

lualine.setup {
  options = {
    icons_enabled = true,
    theme = "auto", -- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
    globalstatus = true,
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "|" },
    disabled_filetypes = { "packer", "NvimTree" },
    refresh = {
      winbar = 600,
      statusline = 2000,
    },
  },

  --tabline =

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

    lualine_x = {},
    lualine_y = { "branch", "diff" },
    lualine_z = {},
  },

  extensions = {
    'aerial',
    'quickfix',
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
