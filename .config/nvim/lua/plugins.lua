-- vim: set fdm=syntax ts=2 sw=2 sts=0 expandtab:
return {

  -- almost dependencies
  { "nvim-lua/popup.nvim", lazy = false, priority = 800 },
  { "nvim-lua/plenary.nvim", lazy = false, priority = 800 },
  { "MunifTanjim/nui.nvim", lazy = false, priority = 800 },
  { "kyazdani42/nvim-web-devicons", lazy = false, priority = 800 },

  -- themes (colorscheme, statusline, ...)
  {
    "rmehri01/onenord.nvim",
    lazy = false,
    priority = 1000,
    init = function() vim.opt.background = "light" end,
    config = true,
  },
  {
    "xiyaowong/nvim-transparent",
    lazy = false,
    priority = 999,
    config = {
      enable = true,
      extra_groups = { "StatusLine", "NvimTreeNormal" },
      excludes = {
        "NoiceCmdlinePopup", "NoiceMini", "NoicePopup",
        "NvimTreeStatusLine",
        "Pmenu",
        "ToggleTerm", "ToggleTermBuffer",
      },
    },
  },
  { -- tab
    "romgrk/barbar.nvim",
    enabled = false,
  },
  { -- statusline
    "nvim-lualine/lualine.nvim",
    event = { "InsertEnter", "CursorHold", "FocusLost", "BufRead", "BufNewFile" },
    dependencies = { "kyazdani42/nvim-web-devicons" },
    init = function()
      vim.opt.laststatus = 0
      vim.opt.showtabline = 0
    end,
    config = function() require("config.statusline") end,
  },

  -- nvim development
  { "dstein64/vim-startuptime", cmd = "StartupTime" },
  "folke/which-key.nvim",
  {
    "folke/neodev.nvim",
    ft = "lua",
    config = {
      lspconfig = {
        cmd = { 'lua-language-server' },
        prefer_null_ls = true,
      },
    },
  },

  -- utility
  { "nishigori/increment-activator", event = { "BufEnter", "BufWinEnter"} },
  { "tyru/open-browser.vim", event = { "BufEnter", "BufWinEnter"} },
  { "petertriho/nvim-scrollbar", config = true, event = { "BufWinEnter", "CmdwinLeave", "VimResized", "WinEnter", "WinScrolled" } },
  { "karb94/neoscroll.nvim", config = true, event = { "BufWinEnter", "CmdwinLeave", "VimResized", "WinEnter", "WinScrolled" } },
  { "uga-rosa/translate.nvim",
    cmd = "Translate",
    config = {
      default = { command = "deepl_free" },
      --preset = { output = { split = { append = true } } },
    },
  },
  --{
  --  "glepnir/dashboard-nvim",
  --  lazy = false,
  --  priority = 800,
  --},
  { "folke/noice.nvim",
    lazy = false,
    priority = 700,
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function() require "config.noice" end,
  },

  -- explorer (filer)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    cmd = "Neotree",
    init = function() vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]]) end,
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
  },

  -- terminal
  { "akinsho/toggleterm.nvim",
    event = { "BufRead", "BufNewFile", "CursorMoved", "CursorHold" },
    config = function ()
      require("toggleterm").setup {
        highlights = {
          Normal = { guibg = "#22272e" }
        },
      }
      -- https://github.com/akinsho/toggleterm.nvim#custom-terminal-usage
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({ cmd = "lazygit -ucd ~/.config/lazygit", direction = "float", hidden = true })
      function _lazygit_toggle()
        lazygit:toggle()
      end
      vim.api.nvim_set_keymap("n", "<C-g>", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
    end
  },

  -- git: I'm using lazygit via toggleterm.nvim

  -- github
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    config = {
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
    },
  },

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
    config = function() require "config.telescope" end,
  },
  -- TODO: integrate telescope
  --{ -- yank
  --  "AckslD/nvim-neoclip.lua",
  --  event = { "BufRead", "BufNewFile" },
  --  config = {
  --    -- TODO: more configure: https://github.com/AckslD/nvim-neoclip.lua#Configuration
  --  },
  --},

  -- text object
  { "folke/todo-comments.nvim", event = { "BufRead", "BufNewFile" } },
  { -- % で block jump をもっと高性能に
    "andymass/vim-matchup",
    event = "User ActuallyEditing",
    init = function()
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_deferred_show_delay = 100
      vim.g.matchup_matchparen_hi_surround_always = 1
      vim.g.matchup_override_vimtex = 1
      vim.g.matchup_delim_start_plaintext = 0
      vim.g.matchup_transmute_enabled = 0
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = {
      fast_wrap = {
        chars = { "{", "[", "(", '"', "'" },
      }
    },
  },

  -- tree-sitter
  { "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",  -- カーソル行のメソッド名などを表示
      "RRethy/nvim-treesitter-endwise",           -- blockのend文自動入力してくれる
      "RRethy/nvim-treesitter-textsubjects",      -- class,method一気に選択できるとか
      "andymass/vim-matchup",
    },
    config = function() require('config.treesitter') end,
  },

  -- highlight
  { -- カーソル文字と同じものを highlight (underline)
    "RRethy/vim-illuminate",
    event = { "BufRead", "BufNewFile" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function() require("illuminate").configure({
      providers = { "lsp", "treesitter", "regex" },
      delay = 100,
      under_cursor = true,
      large_file_cutoff = nil,
      large_file_overrides = nil,
    }) end,
  },
  { --  Highlight arguments' definitions
    "m-demare/hlargs.nvim",
    event = { "BufRead", "BufNewFile" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },
  { -- 検索文字が 何個目/全部で何個 か表示してくれる
    "kevinhwang91/nvim-hlslens",
    event = "CursorMoved",
    --config = [[require("hlslens").setup()]],
    config = true,
  },
  { -- color hightlight (#000000)
    "norcalli/nvim-colorizer.lua",
    event = { "BufRead", "BufNewFile" },
    --config = [[require("colorizer").setup()]],
    config = true,
  },
  { -- color of indent
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufRead", "BufNewFile" },
    init = function()
      vim.g.indent_blankline_char_blankline = '┆'
      vim.g.indent_blankline_use_treesitter = true
      vim.g.indent_blankline_show_first_indent_level = false
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.cmd [[highlight IndentBlankline1 guifg=#E5C07B gui=nocombine]]
      vim.cmd [[highlight IndentBlankline2 guifg=#61AFEF gui=nocombine]]
      vim.cmd [[highlight IndentBlankline3 guifg=#98C379 gui=nocombine]]
      vim.cmd [[highlight IndentBlankline4 guifg=#C678DD gui=nocombine]]
      vim.cmd [[highlight IndentBlankline5 guifg=#E06C75 gui=nocombine]]
      vim.cmd [[highlight IndentBlankline6 guifg=#56B6C2 gui=nocombine]]
    end,
    config = {
      show_end_of_line = true,
      space_char_blankline = " ",
      char_highlight_list = {
        "IndentBlankline1", "IndentBlankline2", "IndentBlankline3",
        "IndentBlankline4", "IndentBlankline5", "IndentBlankline6",
      },
    },
  },

  -- fold
  {
    "kevinhwang91/nvim-ufo",
    event = { "BufRead", "BufNewFile" },
    dependencies = { "kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter" },
    init = function()
      local o = vim.o
      o.foldcolumn = "0"
      o.foldlevel = 99 -- large value depends by nvim-ufo
      o.foldlevelstart = 99
      o.foldenable = true
      o.foldexpr = "nvim_treesitter#foldexpr()"
      o.laststatus = 3
    end,
    config = {
      provider_selector = function(_, _, _) return {"treesitter", "indent"} end
    },
  },

  -- debugger
  "mfussenegger/nvim-dap",
  {
    "rcarriga/nvim-dap-ui",
    event = { "BufRead", "BufNewFile" },
    dependencies = "mfussenegger/nvim-dap",
    --config = [[require('dapui').setup()]],
    config = true,
  },

  -- lsp
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "BufReadPre",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "jayp0521/mason-null-ls.nvim",
      "ray-x/lsp_signature.nvim", -- show function signature when you type
      "hrsh7th/cmp-nvim-lsp",
    },
  },
  { -- lsp: ui
    "glepnir/lspsaga.nvim",
    cmd = "Lspsaga",
    event = "BufReadPre",
    dependencies = "williamboman/mason-lspconfig.nvim",
    config = function() require "config.lsp" end,
  },
  {  -- like Intellij structure
    "stevearc/aerial.nvim",
    cmd = "AerialToggle",
    dependencies = { "neovim/nvim-lspconfig", "nvim-treesitter/nvim-treesitter" },
    config = {
      open_automatic = true,
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
      end,
    },
  },

  -- lsp: diagnostics
  { -- pretty list for showing diagnostics
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    config = { fold_open = "", fold_closed = "" },
  },

  -- completion
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "petertriho/cmp-git",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
      "lukas-reineke/cmp-under-comparator",
      --"hrsh7th/vim-vsnip",
      --"hrsh7th/cmp-vsnip",
      "onsails/lspkind.nvim",
    },
    config = function() require "config.cmp" end,
  },
  {
    "rcarriga/cmp-dap",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp", "rcarriga/nvim-dap-ui" },
  },
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

  -- filetype
  { "nathom/filetype.nvim",
    config = {
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
    },
  },
  {
    "gpanders/editorconfig.nvim",
    event = { "BufRead", "BufNewFile" },
  },

  -- filetype: lua
  { "L3MON4D3/LuaSnip", ft = "lua" },

  -- filetype: go (golang)
  {
    "ray-x/go.nvim",
    ft = "go",
    dependencies = "ray-x/guihua.lua",
    init = function()
      vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
    end,
    config = true
  },

}

--  -- LSP
--  use {
--    "neovim/nvim-lspconfig",
--    "glepnir/lspsaga.nvim", -- light-weight lsp
--    "ray-x/lsp_signature.nvim", -- show function signature when you type
--    { -- LSP diagnostics, code actions, ...
--      "jose-elias-alvarez/null-ls.nvim",
--      requires = {
--        "nvim-lua/plenary.nvim",
--        "neovim/nvim-lspconfig",
--      },
--    },
--    {
--      "williamboman/mason.nvim",
--      requires = { "williamboman/mason-lspconfig.nvim" },
--    },
--    { -- bridge mason.nvim & null-ls.nvim
--      "jayp0521/mason-null-ls.nvim",
--      requires = {
--        "williamboman/mason.nvim",
--        "jose-elias-alvarez/null-ls.nvim",
--      },
--    },
--  }
--
--  -- Completion
--  use {
--    "hrsh7th/nvim-cmp",
--    module = "cmp",
--    requires = {
--      { "hrsh7th/cmp-buffer", event = "InsertEnter" },
--      { "hrsh7th/cmp-cmdline", event = "InsertEnter" },
--      { "petertriho/cmp-git", event = "InsertEnter" },
--      { "hrsh7th/cmp-path", event = "InsertEnter" },
--      { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
--      { "hrsh7th/cmp-nvim-lsp-document-symbol", event = "InsertEnter" },
--      { "hrsh7th/cmp-nvim-lsp-signature-help", event = "InsertEnter" },
--      { "hrsh7th/cmp-nvim-lua", event = "InsertEnter" },
--      { "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
--      { "rcarriga/cmp-dap", after = { "nvim-cmp", "nvim-dap" } },
--      "lukas-reineke/cmp-under-comparator",
--      --{ "hrsh7th/vim-vsnip", event = "InsertEnter" },
--      --{ "hrsh7th/cmp-vsnip", event = "InsertEnter" },
--      { "onsails/lspkind.nvim", opt = true }, -- icons for cmp window
--    },
--    wants = { "LuaSnip", "nvim-dap", "lspkind.nvim" },
--    config = [[require("config.cmp")]],
--    event = { "InsertEnter", "CmdlineEnter" },
--  }
