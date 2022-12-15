local wezterm = require "wezterm"
local act = wezterm.action

-- Change this to match your heuristics for whether the executable path is an editor
function is_an_editor(name)
   return name:find("nvim")
end

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
local function emulate_command(key)
  return {
    key = key,
    mods = 'CMD',
    action = act.Multiple {
      act.SendKey { key = " " },
      act.SendKey { key = "w" },
      act.SendKey { key = key },
    },
  }
end

return {
  --use_ime = false, -- awaiting fixed https://github.com/wez/wezterm/issues/2771
  --debug_key_events = true,
  font = wezterm.font "Hack Nerd Font",
  font_size = 20,
  color_scheme = "Raycast_Light",  -- "Google (light) (terminal.sexy)", "GoogleDark (Gogh)", "GoogleDark (Gogh)", "GitHub Dark"
  colors = {
    -- https://docs.rs/palette/0.4.1/palette/named/index.html#constants
    --cursor_bg = 'khaki',
    --cursor_fg = 'black',
    --background = 'snow',
    tab_bar = {
      background = 'silver',
    },
  },
  window_background_opacity = 0.93, -- transparency
  keys = {
    { key = '\r', mods = 'CTRL', action = act.Multiple {
        act.SendKey { key = " " },
        act.SendKey { key = "w" },
        act.SendKey { key = "-" },
        act.SendKey { key = "r" },
        act.SendKey { key = "c" },
      },
    },
    { key = '\r', mods = 'ALT', action = act.Multiple {
        act.SendKey { key = " " },
        act.SendKey { key = "w" },
        act.SendKey { key = "-" },
        act.SendKey { key = "r" },
        act.SendKey { key = "a" },
      },
    },
    emulate_command('1'),
    emulate_command('6'),
    emulate_command('7'),
    emulate_command('r'),
    emulate_command_shift('n'),
    emulate_command_shift('a'),
    emulate_command_shift('e'),
    emulate_command_shift('l'),
  }
}
