-- vim: set fletype=lua fdm=syntax ts=2 sw=2 sts=0 expandtab:

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- Almost dependencies
  use {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "kyazdani42/nvim-web-devicons",
  }

  -- My Plugins
  use "nishigori/increment-activator"

  -- Utility
  use {
    "tyru/open-browser.vim",
    {
      "petertriho/nvim-scrollbar",
      config = [[require("scrollbar").setup()]],
    },
    { -- notify & popup cmdline
      "folke/noice.nvim",
      requires = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
      config = [[require('noice').setup()]],
    },
    {
      "uga-rosa/translate.nvim",
      cmd = { "Translate" },
      config = function()
        require("translate").setup {
          default = { command = "deepl_free" },
          preset = { output = { split = { append = true } } },
        }
      end,
    },
  }

  -- ColorScheme
  use { "projekt0n/github-nvim-theme",
    config = function()
      require("github-theme").setup{
        theme_style = "dimmed", -- "dark", "dark_colorblind", "dimmed"
        dark_float = true,
        comment_style = "italic",
        --keyword_style = "italic",
        --function_style = "italic",
        --variable_style = "italic",
      }
    end
  }

  -- StatusLine
  use { "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = [[require('config.statusline')]],
  }

  -- Folding
  use { "kevinhwang91/nvim-ufo",
    requires = {
      "kevinhwang91/promise-async",
      "nvim-treesitter/nvim-treesitter",
    },
    after = "nvim-treesitter",
    config = function()
      require("ufo").setup {
        provider_selector = function(bufnr, filetype, buftype)
          return {"treesitter", "indent"}
        end
      }
    end,
  }

  -- Text Object
  use { -- % で block jump をもっと高性能に
    "andymass/vim-matchup",
    setup = [[require('config.matchup')]],
  }
  use { "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    requires = {
      "nvim-treesitter/nvim-treesitter-context",  -- カーソル行のメソッド名などを表示
      "p00f/nvim-ts-rainbow",
      "RRethy/nvim-treesitter-endwise",           -- blockのend文自動入力してくれる
      "RRethy/nvim-treesitter-textsubjects",      -- class,method一気に選択できるとか
    },
    wants = "andymass/vim-matchup",
    config = [[require('config.treesitter')]],
  }

  -- HighLight
  use {
    { -- カーソル文字と同じものを highlight (underline)
      "RRethy/vim-illuminate",
      requires = "nvim-treesitter/nvim-treesitter",
      event = "VimEnter",
      config = function()
        require("illuminate").configure({
          providers = { "lsp", "treesitter", "regex" },
          delay = 100,
          under_cursor = true,
          large_file_cutoff = nil,
          large_file_overrides = nil,
        })
      end
    },
    { --  Highlight arguments' definitions
      "m-demare/hlargs.nvim",
      requires = "nvim-treesitter/nvim-treesitter",
      config = [[require("hlargs").setup()]],
    },
    { -- 検索文字が 何個目/全部で何個 か表示してくれる
      "kevinhwang91/nvim-hlslens",
      config = [[require("hlslens").setup()]],
    },
    { -- color hightlight (#000000)
      "norcalli/nvim-colorizer.lua",
      config = [[require("colorizer").setup()]],
    },
    { -- color of indent
      "lukas-reineke/indent-blankline.nvim",
      setup = function()
        local g = vim.g
        g.indent_blankline_char_blankline = '┆'
        g.indent_blankline_use_treesitter = true
        g.indent_blankline_show_first_indent_level = false
        g.indent_blankline_show_trailing_blankline_indent = false

        vim.cmd [[highlight IndentBlankline1 guifg=#E5C07B gui=nocombine]]
        vim.cmd [[highlight IndentBlankline2 guifg=#61AFEF gui=nocombine]]
        vim.cmd [[highlight IndentBlankline3 guifg=#98C379 gui=nocombine]]
        vim.cmd [[highlight IndentBlankline4 guifg=#C678DD gui=nocombine]]
        vim.cmd [[highlight IndentBlankline5 guifg=#E06C75 gui=nocombine]]
        vim.cmd [[highlight IndentBlankline6 guifg=#56B6C2 gui=nocombine]]
      end,
      config = function()
        require("indent_blankline").setup {
          show_end_of_line = true,
          space_char_blankline = " ",
          char_highlight_list = {
            "IndentBlankline1", "IndentBlankline2", "IndentBlankline3",
            "IndentBlankline4", "IndentBlankline5", "IndentBlankline6",
          },
        }
      end,
    },
  }

  -- Text Operator
  use { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" }
  use { "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function() require("nvim-autopairs").setup {
      fast_wrap = {
        chars = { "{", "[", "(", '"', "'" },
      }
    } end
  }

  -- Explorer
  use { "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeFindFile",
    tag = "nightly",
    config = function()
      require("nvim-tree").setup {
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        view = {
          adaptive_size = true,
          mappings = {
            list = {
              { key = ".", action = "toggle_dotfiles" },
            },
          },
        },
        filters = {
          dotfiles = true,
        }
      }
    end
  }

  -- Search
  use {
    {
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "telescope-frecency.nvim",
        "telescope-fzf-native.nvim",
      },
      wants = {
        "popup.nvim",
        "plenary.nvim",
        "telescope-frecency.nvim",
        "telescope-fzf-native.nvim",
      },
      config = [[require("config/telescope")]],
      cmd = "Telescope",
      module = "telescope",
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release"
            .. " && cmake --build build --config Release"
            .. " && cmake --install build --prefix build"
    },
    {
      "nvim-telescope/telescope-frecency.nvim",
      after = "telescope.nvim",
      requires = {"kkharji/sqlite.lua"},
    },
    "nvim-telescope/telescope-file-browser.nvim",
    "crispgm/telescope-heading.nvim",
  }

  -- Git
  -- TODO:

  -- GitHub
  use { "pwntester/octo.nvim", 
    cmd = { "Octo" },
    config = function()
      require("octo").setup {
        reaction_viewer_hint_icon = "",
        user_icon = " ",
        timeline_marker = "",
        timeline_indent = "2",
        right_bubble_delimiter = "",
        left_bubble_delimiter = "",
        issues = {
          order_by = {
            field = "UPDATED_AT", -- or "CREATED_AT"
            direction = "DESC", -- or "ASC"
          },
        },
        pull_requests = {
          order_by = {
            field = "UPDATED_AT", -- or "CREATED_AT"
            direction = "DESC", -- or "ASC"
          },
        },
      }
    end
  }
  use { "AckslD/nvim-neoclip.lua",
    config = function()
      require("neoclip").setup {
        -- TODO: more configure: https://github.com/AckslD/nvim-neoclip.lua#Configuration
      }
    end,
  }

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    "folke/trouble.nvim", -- pretty list for showing diagnostics
    {
      "williamboman/mason.nvim",
      requires = {
        "williamboman/mason-lspconfig.nvim",
      },
    },
    { -- bridge mason.nvim & null-ls
      "jayp0521/mason-null-ls.nvim",
      module = "mason-null-ls",
      after = "mason.nvim",
      requires = {
        "jose-elias-alvarez/null-ls.nvim", -- LSP diagnostics, code actions, ...
      },
    },
    { "glepnir/lspsaga.nvim", after = "nvim-lspconfig" }, -- light-weight lsp
    -- UI for nvim-lsp progress
    { "j-hui/fidget.nvim", config = [[require("fidget").setup { align = { bottom = false } }]] },
    "SmiteshP/nvim-navic", -- Show your current code context
  }

  -- Snippets
  use { "L3MON4D3/LuaSnip", opt = true }

  -- Completion
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
      "hrsh7th/cmp-nvim-lsp",
      "onsails/lspkind.nvim", -- icons for cmp window
      { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
      { "hrsh7th/cmp-path", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
      { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
      { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" },
      "lukas-reineke/cmp-under-comparator",
      --{ "hrsh7th/vim-vsnip", after = "nvim-cmp" },
      --{ "hrsh7th/cmp-vsnip", after = "nvim-cmp" },
    },
    wants = "LuaSnip",
    config = [[require("config.cmp")]],
    event = { "InsertEnter", "CmdlineEnter" },
  }
  -- TODO: Enable
  --use { "zbirenbaum/copilot.lua",
  --  event = "InsertEnter",
  --  config = function ()
  --    vim.schedule(function()
  --      require("copilot").setup {
  --        copilot_node_command = 'node', -- Node version must be < 18
  --      }
  --    end)
  --  end,
  --}


  -- FileType
  use { "nathom/filetype.nvim",
    config = function()
      require("filetype").setup {
        overrides = {
          extensions = {
            tf = "terraform",
            tfvars = "terraform",
            tfstate = "json",
          },
          complex = {
            [".*git/config"] = "gitconfig",
          },
        },
      }
    end
  }

  -- .editorconfig
  use "gpanders/editorconfig.nvim"

end)
