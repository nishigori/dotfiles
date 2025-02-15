if vim.g.vscode then
  return {}
end

return {
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context", -- カーソル行のメソッド名などを表示
      "RRethy/nvim-treesitter-endwise", -- blockのend文自動入力してくれる
      -- Replaced from incremental_selection by nvim-treesitter
      --"RRethy/nvim-treesitter-textsubjects", -- class,method一気に選択できるとか
    },
    main = "nvim-treesitter.configs",
    opts = {
      highlight = {
        enable = true,
        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = false,
          node_decremental = "<S-CR>",
        },
      },

      textobjects = {
        move = {
          enable = true,
        },
      },

      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },

      endwise = { enable = true },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- stylua: ignore start
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "cmake", "comment", "csv", "cue",
        "diff", "dockerfile",
        "editorconfig", "erlang",
        "gitignore", "go", "gomod", "gosum", "gotmpl", "gowork", "graphql",
        "hcl", "hurl",
        "ini",
        "javascript", "jq", "json", "json5", "jsonnet",
        "lua",
        "make", "markdown", "markdown_inline",
        "nginx",
        "perl", "proto", "python",
        "query",
        "regex", "rst", "ruby", "rust",
        "scala", "sql", "strace",
        "terraform", "tsx", "typescript",
        "vim",
        "xml",
        "yaml",
        "zig",
      })
      -- stylua: ignore end
    end,
  },
}
