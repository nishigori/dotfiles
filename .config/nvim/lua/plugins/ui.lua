if vim.g.vscode then
  return {}
end

return {

  -- better vim.ui
  {
    "stevearc/dressing.nvim", -- I'm using lspsaga.nvim
    enabled = false,
  },

  -- transparency
  {
    "xiyaowong/nvim-transparent",
    lazy = false,
    enabled = false,
    priority = 999,
    opts = {
      enable = true,
      extra_groups = { "StatusLine", "NvimTreeNormal" },
      excludes = {
        "NoiceCmdlinePopup", "NoiceMini", "NoicePopup",
        "NvimTreeStatusLine",
        "Pmenu",
        "ToggleTerm", "ToggleTermBuffer",
      },
    },
  },

  -- scroll
  {
    "petertriho/nvim-scrollbar",
    opts = true,
    event = {
      "BufWinEnter",
      "CmdwinLeave",
      "VimResized",
      "WinEnter",
      "WinScrolled",
    }
  },
  {
    "karb94/neoscroll.nvim",
    opts = true,
    event = {
      "BufWinEnter",
      "CmdwinLeave",
      "VimResized",
      "WinEnter",
      "WinScrolled"
    }
  },

}
