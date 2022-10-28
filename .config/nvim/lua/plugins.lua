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
  use { "rcarriga/nvim-notify",
    config = function()
      require("notify").setup {
        background_colour = 'FloatShadow',
        timeout = 6000,
      }
      vim.notify = require("notify")
    end,
  }
  use { "kevinhwang91/nvim-hlslens",
    config = function()
      require('hlslens').setup()
    end,
  }

  -- Style & Color scheme
  use { "projekt0n/github-nvim-theme",
    config = function()
      require("github-theme").setup{
        theme_style = "dark_colorblind", -- "dark", "dark_colorblind"
        dark_float = true,
        comment_style = "italic",
        --keyword_style = "italic",
        function_style = "italic",
        --variable_style = "italic",
      }
    end
  }
  use { "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("lualine").setup {
        icons_enabled = true,
        theme = "papercolor_dark", -- "auto", ...
      }
    end
  }
  use { "kevinhwang91/nvim-ufo",
    requires = { "kevinhwang91/promise-async" },
    config = function()
      require("ufo").setup {
        provider_selector = function(bufnr, filetype, buftype)
          return {"treesitter", "indent"}
        end
      }
    end,
  }
  use { "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup {
        show_end_of_line = true,
        space_char_blankline = " ",
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
          "IndentBlanklineIndent3",
          "IndentBlanklineIndent4",
          "IndentBlanklineIndent5",
          "IndentBlanklineIndent6",
        },
      }
    end
  }
  use { "nathom/filetype.nvim",
    config = function()
      require("filetype").setup {
        overrides = {
          extensions = {
            tf = "terraform",
            tfvars = "terraform",
          },
          complex = {
            [".*git/config"] = "gitconfig",
          },
        },
      }
    end
  }

  -- Text Object
  use { "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
        ensure_installed = {
          "bash",
          "comment",
          "diff", "dockerfile",
          "erlang",
          "gitignore", "go", "gomod",
          "hcl",
          "json", "json5",
          "lua",
          "make", "markdown",
          "perl", "php", "phpdoc", "proto", "python",
          "rst", "ruby", "rust",
          "scala", "sql",
          "typescript",
          "yaml",
        },
      }
    end,
  }
  use { "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
        delay = 100,
        under_cursor = true,
        large_file_cutoff = nil,
        large_file_overrides = nil,
      })
    end
  }

  -- Text Operator
  use { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" }
  use { "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {
      fast_wrap = {
        chars = { "{", "[", "(", '"', "'" },
      }
    } end
  }

  -- Git, Projects, ...
  use { "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        patterns = { ".git" }
        -- TODO: LSP config & with telescope
      }
    end
  }
  use { "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {}
    end
  }
  use "gpanders/editorconfig.nvim"

  -- Finder
  use { "nvim-telescope/telescope.nvim",
    config = function()
      t = require("telescope")
      t.setup {
        defaults = {
          theme = "dropdown",
          layout_config = {
            vertical = { width = 0.5 },
          },
          path_display = {"smart"},
          file_ignore_patterns = { "%.gz", "node_modules", ".git", ".gitkeep" },
        },
        pickers = {
          colorscheme = {
            enable_preview = true
          }
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                             -- the default case_mode is "smart_case"
          }
        }
      }

      t.load_extension("notify")
      t.load_extension("fzf")

    end,
  }
  use { "nvim-telescope/telescope-fzf-native.nvim",
    run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
  }
  use { "nvim-telescope/telescope-frecency.nvim",
    requires = {"kkharji/sqlite.lua"},
    config = function()
      require("telescope").load_extension("frecency")
    end,
  }
  use { "nvim-telescope/telescope-file-browser.nvim" }
  use { "AckslD/nvim-neoclip.lua",
    config = function()
      require("neoclip").setup {
        -- TODO: more configure: https://github.com/AckslD/nvim-neoclip.lua#Configuration
      }
    end,
  }

  -- LSP
  use { "neovim/nvim-lspconfig" }
  use { "SmiteshP/nvim-navic" }
  use { "williamboman/mason.nvim",
    requires = "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_installation = true,
        -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
        -- NOTE: different names between of `:Mason`, check `:LspInfo`
        ensure_installed = {
          --"actionlint", -- github actions
          "bashls",
          "bufls", -- probuf
          "dockerls",
          "erlangls",
          "gopls",
          "perlnavigator",
          "sumneko_lua", -- lua-language-server
          "terraformls",
          "tflint",
          "tsserver",
          "yamlls",
        }
      })
    end
  }

  -- Completion
  use { "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      --"hrsh7th/vim-vsnip",
      --"hrsh7th/cmp-vsnip",
      "onsails/lspkind.nvim",
    }
  }

end)
