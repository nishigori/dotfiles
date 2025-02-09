if vim.g.vscode then
  return {}
end

return {

  {
    "folke/todo-comments.nvim",
    optional = true,
    event = "BufReadPost",
    config = true,
    keys = {
      { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
      { "<leader>sT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    },
    --cmd = { "TodoTrouble", },
  },

}
