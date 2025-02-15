if vim.g.vscode then
  return {}
end

return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      enabled = true,
      --example = "github",
      preset = {
        header = [[
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⢾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⢋⣩⣭⣿⣿⣿⣿⣿⣿⣿⣿⠛⠛⢿⡿⠁⠿⠁⠉⠉⣿⣿⡿⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢴⣿⣛⣛⣩⣿⣿⣿⣿⣿⣿⡿⠛⠄⠀⠀⠷⠀⠀⠀⠀⢠⣟⠵⠂⠋⠀⠋⠛⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣧⣾⣻⣭⠿⠿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⣼⣿⠂⠃⢴⣶⣧⡉⠀⠀⠀⠀⢀⡠⠤⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣴⣴⣶⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⣹⣄⠖⠀⠀⠓⠀⠀⠀⠀⢀⡇⠀⠀⠀⠓⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⠿⣿⣷⣾⣭⣅⣼⣿⣿⣿⣿⣿⡄⠀⢀⡼⠿⠛⠇⠀⠀⠀⠀⠀⠀⠀⢸⣇⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⡿⢿⣿⣿⣿⣿⣿⣿⣿⠿⠊⠈⠁⠈⢭⣍⣉⡛⠻⠿⣿⠗⠂⠀⠀⠐⠀⠀⠀⠀⠀⠉⠲⠄⡀⠀⠀⢹⠄⠀⠀⠀⠒⠾⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⠀⠀⠀⠁⠈⢁⣸⣿⣿⣿⣿⣿⠟⠁⠈⠀⠀⠀⣠⡔⣡⡴⠶⠂⡰⠂⠀⠀⠀⢀⡔⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠐⠀⠀⠐⠁⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿
⠀⠀⠀⠀⠀⠀⠁⠀⢾⣿⢿⣿⠋⠀⠁⠀⠀⠀⢴⠋⣼⠟⣻⡆⠘⠁⠀⠀⢀⣤⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣷⣤⣄⡰⡄⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⠇⠀⠀⠀⠀⠀⠀⢁⣀⡙⠛⠻⠤⠄⠀⠀⠀⠞⠃⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠊⠙⠂⠀⠀⠀⠀⠀⠀⠐⠓⠹⠈⠑⠆⠆⠀⠀⠀⠀⣠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⠀⠀⠀⠀⠀⢰⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠀⢀⠀⠰⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⠀⠀⠀⡀⠂⠘⠻⢿⠀⠀⠀⠀⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟
⠀⣠⣾⣧⣄⠀⠀⠀⠀⠀⠀⠀⠠⣿⣦⡀⠀⠀⠨⣷⣶⡄⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣽⣿⠿⠋⠁⠀
⠀⣿⣿⣯⣿⡄⠀⠀⠀⠀⠀⢠⠇⣿⡟⠉⠀⠀⠀⡟⠹⠁⠀⠀⠀⢀⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣴⡿⢿⡿⠿⠧⠀⠀⠀⠀⣤⢶⡾⣧⡇⠀⢀⠀⠀⠁⠀⠀⠀⡠⣾⣿⣿⣭⣿⣶⣤⣄⡀⠀⠀⠀⠀⢼⣟⣛⢻⣿⣿⣿⣿⣿⣿⣿⣿⣟⣛⣛⣛⣛⠻⠛⠛⠟⠛⠛
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⢸⣿⣿⡆⠤⠀⠀⣶⣶⣷⣶⠂⠀⠀⠀⠀⢰⣶⣶⣶⡆⠈⠉⣿⣷⣿⣮⠉⠉⠉⠉⠩⠽⠇⠀⠀⠂⠁
⣦⣤⣤⣶⣤⣶⣤⣤⣴⣤⣤⣤⡀⠀⢲⣆⣾⣦⣀⠀⠀⠀⠀⠈⠻⡄⠀⠀⠀⠸⣿⣿⣿⠀⠀⠀⠀⢀⣼⣿⣿⣿⡇⠀⡰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠹⠟⠻⠇⠀⠀⣠⣾⣿⣿⣿⣿⣇⠀⣀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠐⡇⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⡇⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⣐⣿⠁⠀⡆⠀⢹⣿⣶⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿

ッ先頭は6番のカフェファラオ！抜けて連覇達成！ゴールイン！！！]],
      },
    },
    styles = {
      notification = {
        wo = { wrap = true },
      },
    },
  },

    -- stylua: ignore start
    keys = {
      -- My Alias: https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
      { "?", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<c-/>", function() Snacks.picker.lines() end, desc = "Buffer Lines" },

      { "<C-a>", function() Snacks.picker.pickers() end, desc = "Picker list" },
      { "<C-n>", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<C-p>", function() Snacks.picker.recent() end, desc = "Recent" },
      { "<C-g>", function() Snacks.lazygit() end, desc = "Lazygit" },

      -- use <Leader>sc (search command_history)
      --{ "q:", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "qy", function() Snacks.picker.cliphist() end, desc = "Clip (yank) history" },

      -- Use <leader>bd (bufdelete)
      --{ "<leader>d", function() Snacks.bufdelete() end, desc = "Delete Buffer" },

      { "<LocalLeader>f", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
      { "<LocalLeader>g", function() Snacks.picker.git_grep() end, desc = "Find Git Files" },
    },
  -- stylua: ignore end
}
