if vim.g.vscode then
  return {}
end

return {

  { -- TODO: remove if unused at long time
    "romgrk/barbar.nvim",
    enabled = false,
  },

  {
    "echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = {
      { "<leader>d", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader><S-d>", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },

  {
    "akinsho/nvim-bufferline.lua",
    event = "BufAdd",
    init = function()
      vim.api.nvim_set_keymap('n', '<Tab>', '<cmd>bnext<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<S-Tab>', '<cmd>bprevious<CR>', { noremap = true, silent = true })
    end,
    config = function() -- use `config` (no-use `opts` by lazy.nvim) cause highlights executable after set colorscheme: catppuccin
      require("bufferline").setup {
      highlights = require("catppuccin.groups.integrations.bufferline").get(),
      options = {
        diagnostics = "nvim_lsp",
        style = "icon",
        indicator = {
            icon = "▎", -- this should be omitted if indicator style is not 'icon'
            style = "underline", -- 'icon' | 'underline' | 'none',
        },
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = require("icons").diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = " File Explorer",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    }
    end,
  },

}
