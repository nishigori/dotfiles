if vim.g.vscode then
  return {}
end

return {

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    event = "User Later",
    dependencies = {
      "kkharji/sqlite.lua", -- required by frecency
      "nvim-telescope/telescope-frecency.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "crispgm/telescope-heading.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release"
                .. " && cmake --build build --config Release"
                .. " && cmake --install build --prefix build",
      },
    },
    config = function()
      local telescope = require "telescope"

      telescope.setup {

        defaults = {
          theme = "dropdown",
          hidden = true,
          layout_config = {
            prompt_position = "top",
            vertical = { width = 0.5 },
          },
          path_display = { "smart" }, -- smart, shorten, truncate
          --file_ignore_patterns = { "%.gz", "node_modules", ".git", ".gitkeep" },
          sorting_strategy = "ascending", -- or "descending"
        },

        pickers = {
          colorscheme = { enable_preview = true },
          find_files = {
            previewer = false,
            prompt_prefix = "🔍",
            hidden = true,
            no_ignore = true,
            no_ignore_parent = true,
          },
          buffers = {
            ignore_current_buffer = true,
            sort_lastused = true,
            hidden = true,
            previewer = false,
          },
          -- TODO: how specify theme on pickers
          --command_history = { theme = "get_ivy" },
        },

        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- "smart_case" or "ignore_case" or "respect_case"
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
            }
          },
          frecency = {
            disable_devicons = false,
            default_workspace = "CWD",
            workspaces = MY_SECRETS and MY_SECRETS["telescope_frecency_workspaces"] or {},
          },
          heading = { treesitter = true },
          project = {
            base_dirs = {
              {"~/src/github.com", max_depth = 3},
            },
            sync_with_nvim_tree = true,
          },
        }
      }

      -- Extensions (must be after `telescope.setup`)
      telescope.load_extension "frecency"
      telescope.load_extension "fzf"
      telescope.load_extension "noice"
      telescope.load_extension "heading"
      telescope.load_extension "file_browser"
    end
  },

  -- TODO: integrate telescope
  --{ -- yank
  --  "AckslD/nvim-neoclip.lua",
  --  event = { "BufRead", "BufNewFile" },
  --  config = {
  --    -- TODO: more configure: https://github.com/AckslD/nvim-neoclip.lua#Configuration
  --  },
  --},

}
