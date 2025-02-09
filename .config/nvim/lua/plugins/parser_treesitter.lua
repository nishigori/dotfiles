if vim.g.vscode then
  return {}
end

return {

  -- Refs: https://www.lazyvim.org/plugins/treesitter#nvim-treesitter
  -- Refs: https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#lazynvim
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    run = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" }, -- "LazyFile"={ "BufReadPost", "BufNewFile", "BufWritePre" }
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },

    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",  -- カーソル行のメソッド名などを表示
      "RRethy/nvim-treesitter-endwise",           -- blockのend文自動入力してくれる
      "RRethy/nvim-treesitter-textsubjects",      -- class,method一気に選択できるとか
      "andymass/vim-matchup",
    },

    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,

    opts_extend = { "ensure_installed" },
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
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

      auto_install = true,
      sync_install = false,
      ensure_installed = { -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
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
        "rst", "ruby", "rust",
        "scala", "sql", "strace",
        "terraform", "typescript",
        "vim",
        "xml",
        "yaml",
        "zig",
      },

      textobjects = {
        move = {
          enable = true,
        },
      },

      textsubjects = { -- RRethy/nvim-treesitter-textsubjects
        enable = true,
        prev_selection = ',', -- (Optional) keymap to select the previous selection
        keymaps = {
          ['.'] = 'textsubjects-smart',
          --[';'] = 'textsubjects-container-outer',
          --['i;'] = 'textsubjects-container-inner',
        },
      },

      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },

      matchup = { enable = true, disable = {}, }, -- andymass/vim-matchup
      endwise = { enable = true },
    },

    ---@param opts TSConfig
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

}
