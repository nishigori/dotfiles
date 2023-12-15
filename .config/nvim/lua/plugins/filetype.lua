if vim.g.vscode then
  return {}
end

return {

  -- better filetype
  { "nathom/filetype.nvim",
    config = {
      overrides = {
        extensions = {
          hcl = "tf",
          --tf = "terraform",
          tfvars = "tf",
          tfstate = "json",
          json5 = "json",
          jsonc = "json",
          sh    = "bash",
        },
        complex = {
          [".*git/config"] = "gitconfig",
        },
      },
    },
  },

  {
    "gpanders/editorconfig.nvim",
    event = "BufReadPost",
  },

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

  -- golang
  {
    "ray-x/go.nvim",
    ft = "go",
    dependencies = "ray-x/guihua.lua",
    init = function()
      vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
    end,
    config = true
  },

}
