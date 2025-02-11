if vim.g.vscode then
  return {}
end

return {

  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",

    -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#todo_comments
    optional = true,
    keys = {
      { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
      { "<leader>sT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    },
  },

}
