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

  -- andymass/vim-matchup
  matchup = {
    enable = true,
    disable = {},
  },

  -- RRethy/nvim-treesitter-textsubjects
  textsubjects = {
    enable = true,
    prev_selection = ',', -- (Optional) keymap to select the previous selection
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
      ['i;'] = 'textsubjects-container-inner',
    },
  },

  endwise = {
    enable = true,
  },

  -- p00f/nvim-ts-rainbow
  rainbow = {
    enable = true,
    extended_module = true,
    max_file_lines = 2500,
  },

}

require("treesitter-context").setup {
  enable = true,
}
