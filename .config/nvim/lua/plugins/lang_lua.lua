if vim.g.vscode then
  return {}
end

return {

  -- nvim development
  { "dstein64/vim-startuptime", cmd = "StartupTime" },

  {
    "folke/neodev.nvim",
    ft = "lua",
    config = {
      lspconfig = {
        cmd = { 'lua-language-server' },
        prefer_null_ls = true,
      },
    },
  },


}
