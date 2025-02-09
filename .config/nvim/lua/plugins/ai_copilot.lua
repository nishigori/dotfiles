
if vim.g.vscode then
  return {}
end

return {

  {
    "zbirenbaum/copilot.lua",
    enabled = false, -- TODO: enabled buy github copilot
    event = "InsertEnter",
    config = function ()
      vim.schedule(function()
        require("copilot").setup {
          copilot_node_command = 'node', -- Node version must be < 18
        }
      end)
    end,
  },

}
