if vim.g.vscode then
  return {}
end

return {
  { "uga-rosa/translate.nvim",
    cmd = "Translate",
    opts = {
      default = { command = "deepl_free" },
      --preset = { output = { split = { append = true } } },
    },
    keys = {
      -- FIXME: 書き方間違ってるかも
      --keymap('n', '<leader>t', '<cmd>Translate JA<CR>', silent)
      --keymap('x', '<leader>t', '<cmd>Translate JA<CR>', silent)
      --{ "<C-t>", { "<cmd>Translate JA<cr>", mode = "x" } },
    },
  },
}
