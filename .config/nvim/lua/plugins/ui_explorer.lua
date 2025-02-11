if vim.g.vscode then
  return {}
end

return {
  -- neo-tree.nvim vs snacks.nvim explorer
  --
  -- neo-tree.nvim:
  --   * pros
  --   * cons
  --
  -- snacks.nvim:
  --   * pros
  --     * Explorer search が優秀
  --   * cons
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },

    config = {
      window = {
        width = 38,
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          never_show_by_pattern = { "*.gz", "*.zip" },
        },
      },
    },

    -- FIXME1: why enabled mapped ":"
    --keys = {
    --  { ":", "<cmd>Neotree toggle reveal<cr>", desc = "Toggle explorer" },
    --},

    -- https://github.com/folke/snacks.nvim/blob/main/docs/rename.md#neo-treenvim
    opts = function(_, opts)
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end
      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
    end,

  },

}
