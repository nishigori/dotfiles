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
    "echasnovski/mini.comment",
    event = "BufReadPost",
  },

  {
    "gpanders/editorconfig.nvim",
    event = "BufReadPost",
  },

}
