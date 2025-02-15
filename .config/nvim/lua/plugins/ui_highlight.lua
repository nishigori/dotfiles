if vim.g.vscode then
  return {}
end

return {
  -- I'm using Snacks.nvim
  --{ "lukas-reineke/indent-blankline.nvim", },

  -- I'm using LazyVim
  --{ -- カーソル文字と同じものを highlight (underline)
  --  "RRethy/vim-illuminate",
  --  event = "BufReadPost",
  --  opts = { delay = 200 },
  --  dependencies = "nvim-treesitter/nvim-treesitter",
  --  config = function() require("illuminate").configure({
  --    providers = { "lsp", "treesitter", "regex" },
  --    delay = 100,
  --    under_cursor = true,
  --    large_file_cutoff = nil,
  --    large_file_overrides = nil,
  --  }) end,
  --},

  { --  Highlight arguments' definitions
    "m-demare/hlargs.nvim",
    event = "BufReadPost",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },

  { -- 検索文字が 何個目/全部で何個 か表示してくれる
    "kevinhwang91/nvim-hlslens",
    event = "BufReadPost",
    config = true,
  },
}
