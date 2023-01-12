return {

  -- tree-sitter
  { "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = "BufReadPost",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",  -- カーソル行のメソッド名などを表示
      "RRethy/nvim-treesitter-endwise",           -- blockのend文自動入力してくれる
      "RRethy/nvim-treesitter-textsubjects",      -- class,method一気に選択できるとか
      "andymass/vim-matchup",
    },
    opts = {
      indent = { enable = true },
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
      ensure_installed = { -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
        "bash",
        "comment",
        "diff", "dockerfile",
        "erlang",
        "gitignore", "go", "gomod",
        "hcl",
        "help",
        "json", "json5",
        "lua",
        "make", "markdown", "markdown_inline",
        "perl", "php", "phpdoc", "proto", "python",
        "rst", "ruby", "rust",
        "scala", "sql",
        "typescript",
        "yaml",
      },
      textsubjects = { -- RRethy/nvim-treesitter-textsubjects
        enable = true,
        prev_selection = ',', -- (Optional) keymap to select the previous selection
        keymaps = {
          ['.'] = 'textsubjects-smart',
          [';'] = 'textsubjects-container-outer',
          ['i;'] = 'textsubjects-container-inner',
        },
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      matchup = { enable = true, disable = {}, }, -- andymass/vim-matchup
      endwise = { enable = true },
    },
    config = function()
      require("treesitter-context").setup {
        enable = true,
      }
    end
  },

}
