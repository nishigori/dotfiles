if vim.g.vscode then
  return {}
end

return {

  {
    "ray-x/go.nvim",
    event = { "CmdlineEnter" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    ft = { "go", "go.mod" },
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },

    init = function()
      vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
    end,

    config = function()
      require("go").setup()
    end,
  },

}
