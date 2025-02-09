if vim.g.vscode then
  return {}
end

return {

  -- Diagnostics shows list and others (like Intellij `Problems`)
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      use_diagnostic_signs = true ,
      fold_open = "",
      fold_closed = "",
    },
  },

}
