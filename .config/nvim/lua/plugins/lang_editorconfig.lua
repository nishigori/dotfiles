if vim.g.vscode then
  return {}
end

return {
  "gpanders/editorconfig.nvim",
  event = "BufReadPost",
}
