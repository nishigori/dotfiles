local wezterm = require "wezterm"
local act = wezterm.action

return {
  --debug_key_events = true,
  color_scheme = "GitHub Dark",
  font = wezterm.font "Hack Nerd Font",
  font_size = 17.5,
  keys = {
    {
      key = '\r',
      mods = 'CTRL',
      action = act.Multiple {
        act.SendKey { key = " " },
        act.SendKey { key = "w" },
        act.SendKey { key = "e" },
      },
    },
  }
}
