return {

  -- File explorer
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

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "契" },
        topdelete = { text = "契" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
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

  -- Terminal
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
      function LAZYGIT_TOGGLE()
        lazygit:toggle()
      end
      vim.api.nvim_set_keymap("n", "<C-g>", "<cmd>lua LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true })
    end
  },

  -- Code outline window (like Intellij `structure`)
  {
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

  -- Diagnostics shows list and others (like Intellij `Problems`)
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      use_diagnostic_signs = true ,
      fold_open = "",
      fold_closed = "",
    },
  },

  -- Todo
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = true,
  },

  -- Debugger
  "mfussenegger/nvim-dap",
  {
    "rcarriga/nvim-dap-ui",
    event = { "BufRead", "BufNewFile" },
    dependencies = "mfussenegger/nvim-dap",
    config = true,
  },

  -- Folding
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

  -- Highlight
  { -- カーソル文字と同じものを highlight (underline)
    "RRethy/vim-illuminate",
    event = { "BufReadPost" },
    opts = { delay = 200 },
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
    event = { "BufReadPost" },
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
    opts = {
      show_end_of_line = true,
      space_char_blankline = " ",
      char_highlight_list = {
        "IndentBlankline1", "IndentBlankline2", "IndentBlankline3",
        "IndentBlankline4", "IndentBlankline5", "IndentBlankline6",
      },
    },
  },

}
