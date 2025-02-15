if vim.g.vscode then
  return {}
end

return {
  -- TODO: しばらく経って困ってなければファイルごと消す
  -- better filetype
  --"nathom/filetype.nvim",
  --enabled = false,
  --config = {
  --  overrides = {
  --    extensions = {
  --      hcl = "tf",
  --      --tf = "terraform",
  --      tfvars = "tf",
  --      tfstate = "json",
  --      json5 = "json",
  --      jsonc = "json",
  --      sh = "bash",
  --    },
  --    complex = {
  --      [".*git/config"] = "gitconfig",
  --    },
  --  },
  --},
}
