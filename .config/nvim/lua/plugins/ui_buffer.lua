if vim.g.vscode then
  return {}
end

return {

  -- I'm using Snacks.bufdelete()
  --"echasnovski/mini.bufremove",

  { -- Layout like tab bar
    "akinsho/nvim-bufferline.lua",

    event = "BufAdd",

    init = function()
      vim.api.nvim_set_keymap('n', '<Tab>', '<cmd>bnext<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<S-Tab>', '<cmd>bprevious<CR>', { noremap = true, silent = true })
    end,

    -- No used `opts` for lazy.nvim
    -- highlights executable after set colorscheme: catppuccin
    config = function()
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
            filetype = "snacks_picker_list",
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

