if vim.g.vscode then
  return {}
end

return {

  {
    "kevinhwang91/nvim-ufo",
    event = { "BufRead", "BufNewFile" },
    dependencies = { "kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter" },
    init = function()
      local o = vim.o
      o.foldcolumn = "0"
      o.foldlevel = 99 -- large value depends by nvim-ufo
      o.foldlevelstart = 99
      o.foldenable = true
      o.foldexpr = "nvim_treesitter#foldexpr()"
      o.laststatus = 3
    end,
    config = {
      provider_selector = function(_, _, _) return {"treesitter", "indent"} end
    },
  },

}
