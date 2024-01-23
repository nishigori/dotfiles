local wezterm = require "wezterm"
local act = wezterm.action

-- Change this to match your heuristics for whether the executable path is an editor
function IS_AN_EDITOR(name)
   return name:find("nvim")
end

-- https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html
function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab_title(tab)
    if tab.is_active then
      return {
        { Background = { Color = 'green' } },
        { Text = ' ' .. title .. ' ' },
      }
    end
    return title
  end
)

local function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return "Catppuccin Mocha"
  else
    return "Catppuccin Latte"
  end
end

local scheme = scheme_for_appearance(wezterm.gui.get_appearance())
local custom = wezterm.color.get_builtin_schemes()[scheme]
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
  --font = wezterm.font "MonaspiceXe Nerd Font",
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
      background = '#0bbb22',
      --inactive_tab_edge = '#ffffff',
    },
  },
  window_background_opacity = 1.00, -- transparency
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
    {
      key = 'd',
      mods = 'CMD',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = '[',
      mods = 'CMD',
      action = act.ActivatePaneDirection 'Prev',
    },
    {
      key = ']',
      mods = 'CMD',
      action = act.ActivatePaneDirection 'Next',
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
