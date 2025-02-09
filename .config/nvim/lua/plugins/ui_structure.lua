if vim.g.vscode then
  return {}
end

return {

  -- Code outline window (like Intellij `structure`)
  {
    "stevearc/aerial.nvim",
    cmd = "AerialToggle",
    dependencies = { "neovim/nvim-lspconfig", "nvim-treesitter/nvim-treesitter" },
    config = {
      open_automatic = true,
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
      end,
    },
  },

}
