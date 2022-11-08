local wezterm = require "wezterm"
local act = wezterm.action

-- for nvim
local function emulate_command_shift(key)
  return {
    key = key,
    mods = 'CMD|SHIFT',
    action = act.Multiple {
      act.SendKey { key = " " },
      act.SendKey { key = "w" },
      act.SendKey { key = key },
    },
  }
end

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
        act.SendKey { key = "r" },
      },
    },
    emulate_command_shift('n'),
    emulate_command_shift('a'),
    emulate_command_shift('e'),
    emulate_command_shift('l'),
  }
}
