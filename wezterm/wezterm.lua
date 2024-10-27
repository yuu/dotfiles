local wezterm = require 'wezterm'
local keybinds = require 'keybinds'

local config = wezterm.config_builder()

local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

function to_padding(name, pad_size)
  local length = #name
  if length < pad_size then
    name = name .. string.rep(" ", pad_size - length)
  end
  return name
end

function basename(s)
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

function on_format_tab_title(tab, tabs, _, _, _, max_width)
  local background = '#282828'
  local foreground = '#d8dee9'

  local name = basename(tab.active_pane.foreground_process_name)
  local title = '  ' .. to_padding(name, max_width)

  if tab.is_active then
    background = '#87CEFA'
    foreground = 'black'
  end

  return {
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
  }
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme_dirs = { '/Users/yuu/.config/wezterm' }
config.color_scheme = 'nord'

config.tab_max_width = 25
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
-- config.show_close_tab_button_in_tabs = false -- nightly
config.macos_window_background_blur = 20
config.window_background_opacity = 0.85
config.window_decorations = 'RESIZE'
config.window_background_gradient = {
  colors = { '#000000' },
}

config.font = wezterm.font('Source Han Code JP', { weight = 'Bold', italic = false })
config.font_size = 16

config.disable_default_key_bindings = true
config.leader = keybinds.leader
config.keys = keybinds.keys
config.key_tables = keybinds.key_tables

wezterm.on('format-tab-title', on_format_tab_title)

return config
