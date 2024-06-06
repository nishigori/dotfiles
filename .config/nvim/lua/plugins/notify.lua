if vim.g.vscode then
  return {}
end

local load_priority = 700

return {

  -- better vim.notify
  {
    "rcarriga/nvim-notify",
    lazy = false,
    priority = load_priority,
    opts = {
      --background_colour = "#22272e",
    }
  },

  {
    "folke/noice.nvim",
    version = "*",
    lazy = false,
    priority = load_priority,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      local ignore_msg = function (msg, kind)
        return {
          opts = { skip = true },
          filter = {
            event = "msg_show",
            kind = kind or "",
            find = msg,
          }
        }
      end

      require('noice').setup {

        messages = {
          view = "mini",
          view_warn = "mini",
        },

        views = {
          -- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes#display-the-cmdline-and-popupmenu-together
          cmdline_popup = {
            position = { row = 5, col = "50%" },
            size = { width = 60, height = "auto" },
          },
          popupmenu = {
            relative = "editor",
            position = { row = 8, col = "50%" },
            size = { width = 60, height = 10 },
            border = { style = "rounded", padding = { 0, 1 } },
            win_options = { winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" } },
          },
        },

        routes = {
          ignore_msg("search_count"), -- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes#hide-search-virtual-text
          ignore_msg("", "written"), -- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes#hide-written-messages-1
          ignore_msg(".*E384.*", "emsg"), -- Search hit *
          ignore_msg(".*E385.*", "emsg"), -- Search hit *
          ignore_msg(".*E433.*", "emsg"), -- No tags file
          ignore_msg(".*E486.*", "emsg"), -- Pattern not found
          ignore_msg(".*E555.*", "emsg"), -- at bottom of tag stack
        },

        lsp = {
          signature = { enabled = false }, -- used lspsaga
        },

      }
    end,
  },

}
