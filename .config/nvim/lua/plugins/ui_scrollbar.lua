if vim.g.vscode then
  return {}
end

return {

    {
      "petertriho/nvim-scrollbar",
      event = { "CmdwinLeave", "WinScrolled" },
      config = true,
    },

}
