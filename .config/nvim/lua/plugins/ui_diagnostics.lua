if vim.g.vscode then
  return {}
end

return {

  -- Diagnostics shows list and others (like Intellij `Problems`)
  {
    "folke/trouble.nvim",
    cmd = "Trouble",

    keys = {
      ",d",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },

    opts = {
      modes = {
        diagnostics = { auto_open = true },
      }
    },

    -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#trouble
    specs = {
      "folke/snacks.nvim",
      opts = function(_, opts)
        return vim.tbl_deep_extend("force", opts or {}, {
          picker = {
            actions = require("trouble.sources.snacks").actions,
            win = {
              input = {
                keys = {
                  ["<c-t>"] = { "trouble_open", mode = { "n", "i" }, },
                },
              },
            },
          },
        })
      end,
    },
  },

}
