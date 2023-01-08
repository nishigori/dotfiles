require("notify").setup({ background_colour = "#22272e" })

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
    { -- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes#hide-search-virtual-text
      filter = { event = "msg_show", kind = "search_count" },
      opts = { skip = true },
    },
    { -- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes#hide-written-messages-1
      filter = { event = "msg_show", kind = "", find = "written" },
      opts = { skip = true },
    },
    {
      filter = {
        event = "msg_show",
        kind = "emsg",
        find = "E486: Pattern not found",
      },
      opts = { skip = true },
    },
  },

  lsp = {
    signature = { enabled = false }, -- used lspsaga
  },

}

vim.api.nvim_set_hl(0, "NoiceMini", { bg = "none" })
