if vim.g.vscode then
  return {}
end

return {

  -- Abobe as without LazyVim

  {
    "uga-rosa/translate.nvim",
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

  {
    "sontungexpt/url-open",
    event = "BufReadPost",
    cmd = "URLOpenUnderCursor",
    config = function()
      local status_ok, url_open = pcall(require, "url-open")
      if not status_ok then
        return
      end
      url_open.setup({})
    end,
    keys = {
      { "<Leader>O", "<esc>:URLOpenUnderCursor<cr>", desc = "Open URL" },
    },
  },
}
