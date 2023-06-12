local m = {
  { "nishigori/increment-activator", event = { "BufEnter", "BufWinEnter"} },
  { "tyru/open-browser.vim", event = { "BufEnter", "BufWinEnter"} },
}

if not vim.g.vscode then
  local m2 = {
    -- almost dependencies
    { "nvim-lua/popup.nvim", lazy = false, priority = 800 },
    { "nvim-lua/plenary.nvim", lazy = false, priority = 800 },
    { "MunifTanjim/nui.nvim", lazy = false, priority = 800 },
    { "kyazdani42/nvim-web-devicons", lazy = false, priority = 800 },

    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        plugins = { spelling = true },
        key_labels = { ["<leader>"] = "SPC" },
      },
    },

    { "uga-rosa/translate.nvim",
      cmd = "Translate",
      config = {
        default = { command = "deepl_free" },
        --preset = { output = { split = { append = true } } },
      },
    },

    -- session management
    {
      "folke/persistence.nvim",
      event = "BufReadPre",
      opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
      -- stylua: ignore
      keys = {
        { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
        { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
        { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
      },
    },

    { "petertriho/nvim-scrollbar", config = true, event = { "BufWinEnter", "CmdwinLeave", "VimResized", "WinEnter", "WinScrolled" } },
    { "karb94/neoscroll.nvim", config = true, event = { "BufWinEnter", "CmdwinLeave", "VimResized", "WinEnter", "WinScrolled" } },

  }

  for k,v in pairs(m2) do m[k] = v end
end

return m
