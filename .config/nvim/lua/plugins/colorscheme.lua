return {

  --{
  --  "folke/tokyonight.nvim",
  --  enabled = true,
  --  lazy = false,
  --  priority = 1000,
  --  opts = { style = "moon" },
  --  --init = function() vim.opt.background = "light" end,
  --  --opts = function(_, opts)
  --  --  local tokyonight = require("tokyonight")
  --  --  tokyonight.setup(opts)
  --  --  tokyonight.load()
  --  --end,
  --},

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
          mason = true,
          neotree = true,
          noice = true,
          cmp = true,
          gitsigns = true, -- not using yet
          notify = true,
          treesitter = true,
          treesitter_context = true,
          telescope = true,
          illuminate = true,
          which_key = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
          },
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

  --{
  --  "rmehri01/onenord.nvim",
  --  enabled = false,
  --  lazy = false,
  --  priority = 1000,
  --  init = function() vim.opt.background = "light" end,
  --  opts = true,
  --},

}
