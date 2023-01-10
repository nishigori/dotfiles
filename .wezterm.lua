local wezterm = require "wezterm"
local act = wezterm.action

-- Change this to match your heuristics for whether the executable path is an editor
   return name:find("nvim")
end

local custom = wezterm.color.get_builtin_schemes()['Catppuccin Latte']
--custom.background = "#000000"
custom.tab_bar.background = "#040404"
custom.tab_bar.inactive_tab.bg_color = "#0f0f0f"
custom.tab_bar.new_tab.bg_color = "#080808"

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
  font_size = 22,
  line_height = 1.1,
  color_schemes = {
    ['OLEDppuccin'] = custom,
  },
  color_scheme = "OLEDppuccin", -- or Mocha, Macchiato, Frappe, Latte
  --color_scheme = "Google (light) (terminal.sexy)",  -- "Raycast_Light", "Google (light) (terminal.sexy)", "GoogleDark (Gogh)", "GoogleDark (Gogh)", "GitHub Dark"
  colors = {
    -- https://docs.rs/palette/0.4.1/palette/named/index.html#constants
    cursor_bg = 'deeppink',
    cursor_fg = 'greenyellow',
    --background = 'snow',
    tab_bar = {
      background = 'silver',
    },
  },
  window_background_opacity = 0.94, -- transparency
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
    emulate_command('e'),
    emulate_command('r'),
    emulate_command_shift('n'),
    emulate_command_shift('a'),
    emulate_command_shift('l'),
  }
}
