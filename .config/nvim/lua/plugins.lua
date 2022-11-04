-- vim: set fletype=lua fdm=syntax ts=2 sw=2 sts=0 expandtab:

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
  use "tyru/current-func-info.vim"
  use "tyru/open-browser.vim"
  use { "uga-rosa/translate.nvim",
    config = function()
      require("translate").setup {
        default = {
          command = "deepl_free",
        },
        preset = {
        output = {
            split = {
                append = true,
            },
        },
    },
      }
    end,
  }
  use { "folke/noice.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      vim.o.cmdheight = 0
      require("noice").setup()
    end,
  }
  use { "kevinhwang91/nvim-hlslens", config = function() require("hlslens").setup() end }
  use { "petertriho/nvim-scrollbar", config = function() require("scrollbar").setup() end }

  -- Style & Color scheme
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
  use { "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      vim.o.laststatus = 0
      require("lualine").setup {
        icons_enabled = true,
        theme = "papercolor_dark", -- "auto", ...
        tabline = {
          lualine_a = {
            -- Show git project of git
            function() return vim.fn.fnamemodify(vim.fn.finddir(".git/..", ".;"), ":t") end,
          },
          lualine_b = {
            -- The relative path under the git-root
            function()
              return string.gsub(
                vim.api.nvim_buf_get_name(0),
                vim.fn.fnamemodify(vim.fn.finddir(".git/..", ".;"), ":p"), --vim.loop.cwd(),
                '')
            end,
          },
          lualine_c = {
            -- Get current function name from tyru/current-func-info.vim
            function() return vim.api.nvim_eval('cfi#format("%s", "")') end,
          },
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_lsp", "nvim_diagnostic" },
              sections = { "error", "warn", "info", "hint" },
              colored = true,
              update_in_insert = false,
              always_visible = true,
              diagnostics_color = {
                -- Same values as the general color option can be used here.
                error = "DiagnosticError", -- Changes diagnostics' error color.
                warn  = "DiagnosticWarn",  -- Changes diagnostics' warn color.
                info  = "DiagnosticInfo",  -- Changes diagnostics' info color.
                hint  = "DiagnosticHint",  -- Changes diagnostics' hint color.
              },
            },
          },
          lualine_y = {"branch", "diff"},
          lualine_z = {
            function() return [[]] end,
            "mode",
          },
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        options = {
          globalstatus = true,
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "|" },
        },
      }
    end
  }
  use { "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
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
            tfstate = "json",
          },
          complex = {
            [".*git/config"] = "gitconfig",
          },
        },
      }
    end
  }

  -- Text Object
  use { "andymass/vim-matchup" } -- % で block jump をもっと高性能に
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
        rainbow = {
          enable = true,
          extended_module = true,
          max_file_lines = 2500,
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
        -- andymass/vim-matchup
        matchup = {
          enable = true,
          disable = {},
        }
      }
    end,
  }
  use { "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true,
      }
    end,
  }
  use { "p00f/nvim-ts-rainbow" }
  use { "m-demare/hlargs.nvim", config = function() require("hlargs").setup() end }
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

  -- Git
  use { "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {}
    end
  }
  use "gpanders/editorconfig.nvim"

  -- Explorer
  use { "nvim-tree/nvim-tree.lua",
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

  -- Finder
  use { "nvim-telescope/telescope.nvim",
    config = function()
      t = require("telescope")
      t.setup {
        defaults = {
          theme = "dropdown",
          hidden = true,
          layout_config = {
            prompt_position = "top",
            vertical = { width = 0.5 },
          },
          path_display = {"smart"},
          file_ignore_patterns = { "%.gz", "node_modules", ".git", ".gitkeep" },
          sorting_strategy = "descending", -- or "ascending"
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
          builtin = {
            --theme = "get-cursor",
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
            workspaces = MY_SECRETS and MY_SECRETS["telescope_frecency_workspaces"] or {},
          },
          project = {
            base_dirs = {
              {"~/src/github.com", max_depth = 3},
            },
            sync_with_nvim_tree = true,
          },
        }
      }

      t.load_extension("noice")
      t.load_extension("fzf")
      t.load_extension("projects")
      t.load_extension("frecency")

    end,
  }
  use { "nvim-telescope/telescope-fzf-native.nvim",
    run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release"
          .. " && cmake --build build --config Release"
          .. " && cmake --install build --prefix build"
  }
  use { "nvim-telescope/telescope-frecency.nvim",
    requires = {"kkharji/sqlite.lua"},
  }
  use { "nvim-telescope/telescope-file-browser.nvim" }
  use { "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        datapath = vim.fn.stdpath("data"),
        patterns = { ".git" }
        -- TODO: LSP config & with telescope
      }
    end
  }
  use { "pwntester/octo.nvim", 
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
  use { "jayp0521/mason-null-ls.nvim",
    requires = {
      "jose-elias-alvarez/null-ls.nvim", -- LSP diagnostics, code actions, ...
      "williamboman/mason.nvim",
    },
    config = function()
      -- vim辞書がなければダウンロード
      if vim.fn.filereadable("~/.local/share/cspell/vim.txt.gz") ~= 1 then
        io.popen("curl -fsSLo ~/.local/share/cspell/vim.txt.gz --create-dirs "
                 .. "https://github.com/iamcco/coc-spell-checker/raw/master/dicts/vim/vim.txt.gz")
      end
      if vim.fn.filereadable("~/.config/cspell/user.txt") ~= 1 then
        io.popen("mkdir -p ~/.config/cspell")
        io.popen("touch ~/.config/cspell/user.txt")
      end

      null_ls = require("null-ls")
      null_ls.setup {
        sources = {
          null_ls.builtins.diagnostics.cspell.with({
            extra_args = { "--config", "~/.config/cspell/cspell.json" },
            diagnostics_postprocess = function(diagnostic)
              diagnostic.severity = vim.diagnostic.severity["WARN"] -- default "ERROR"
            end,
            condition = function()
              return vim.fn.executable('cspell') > 0
            end,
          })
        },
      }
      require("mason-null-ls").setup {
        automatic_setup = true,
        -- https://github.com/jayp0521/mason-null-ls.nvim#available-null-ls-sources
        ensure_installed = {
          "buildifier", -- bzl
          "cspell", -- spell checker
          "hadolint", -- dockerfile
          "goimports", -- go
          "stylua", -- lua
          "buf", -- protobuf
          "psalm", -- php
          "jq", -- json
        }
      }
    end
  }
  use { "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        fold_open = "",
        fold_closed = "",
      }
    end
  }
  use { "glepnir/lspsaga.nvim", -- light-weight lsp
    branch = "main",
    config = function()
      local saga = require("lspsaga")

      saga.init_lsp_saga({
        -- TODO: configuration
      })
    end
  }
  use { "j-hui/fidget.nvim", -- UI for nvim-lsp progress
    config = function()
      require("fidget").setup {
        align = {
          bottom = false,
        }
      }
    end
  }

  -- Completion
  use { "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      --"hrsh7th/vim-vsnip",
      --"hrsh7th/cmp-vsnip",
      "onsails/lspkind.nvim",
    },
    config = function()
      require("cmp").setup.cmdline(";", {
        source = { name = "cmdline" }
      })
      require("cmp").setup.cmdline("/", {
        source = { name = "buffer" }
      })
    end
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

end)
