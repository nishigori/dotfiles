-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- Almost dependencies
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"
  use "MunifTanjim/nui.nvim"
  use "kyazdani42/nvim-web-devicons"

  -- My Plugins
  use "nishigori/increment-activator"

  -- Utility
  use "tyru/open-browser.vim"
  use "tyru/urilib.vim"

  -- Syntax
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use {
    "yamatsum/nvim-cursorline",
    config = function()
      require("nvim-cursorline").setup {
        cursorline = {
          enable = true,
          timeout = 1000,
          number = false,
        },
        cursorword = {
          enable = true,
          min_length = 3,
          hl = { underline = true },
        }
      }
    end
  }

  -- Text Operator
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {
      fast_wrap = {
        chars = { '{', '[', '(', '"', "'" },
      }
    } end
  }

  -- Git, Projects, ...
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        patterns = { ".git" }
        -- TODO: LSP config
      }
    end
  }

  -- Finder
  use {
    "nvim-telescope/telescope.nvim",
  }
  use {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require"telescope".load_extension("frecency")
    end,
    requires = {"kkharji/sqlite.lua"}
  }
  use { "nvim-telescope/telescope-file-browser.nvim" }

end)
