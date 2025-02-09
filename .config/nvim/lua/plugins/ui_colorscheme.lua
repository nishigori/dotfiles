if vim.g.vscode then
  return {}
end

return {

  {
    "folke/tokyonight.nvim",
    lazy = false,
    enabled = true,
    priority = 1000,
    opts = { style = "moon" },
    --init = function() vim.opt.background = "light" end,
    --opts = function(_, opts)
    --  local tokyonight = require("tokyonight")
    --  tokyonight.setup(opts)
    --  tokyonight.load()
    --end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        flavour = "macchiato", -- latte, frappe, macchiato, mocha
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,
        term_colors = true,
        integrations = {
          -- https://github.com/catppuccin/nvim#integrations
          aerial = true,
          overseer = true,
          mason = true,
          noice = true,
          cmp = true,
          gitsigns = true, -- not using yet
          lsp_trouble = true,
          notify = false,
          slacks = false,
          treesitter = true,
          treesitter_context = true,
          illuminate = true,
          which_key = true,
          native_lsp = {
            enabled = true,
          },
          dap = {
            enabled = true,
            enable_ui = true, -- enable nvim-dap-ui
          },
          -- Followings is defined by each plugins config
          -- airline, bufferline
        }

      }
      vim.cmd.colorscheme "catppuccin"
    end
  },

}
