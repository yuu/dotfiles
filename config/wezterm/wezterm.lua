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

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
--
-- tab_info.tab_title: tab:set_title() or wezterm cli set-tab-title
-- tab_info.active_pane.title: titlechange function via precmd / preexec
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

function on_format_tab_title(tab, tabs, _, _, _, max_width)
  local background = '#282828'
  local foreground = '#d8dee9'

  --local name = basename(tab.active_pane.foreground_process_name)
  local name = tab_title(tab)
  local available = max_width - 2
  if #name > available then
    name = string.sub(name, 1, available)
  end
  local title = '  ' .. to_padding(name, available)

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

function on_open_uri(window, pane, uri)
  pane:send_text('bcat ' .. wezterm.shell_quote_arg(uri) .. '\n')
  return false
end

-- wezterm.on('open-uri', on_open_uri)

-- This is where you actually apply your config choices
config.initial_rows = 50
config.initial_cols = 180
config.audible_bell = 'Disabled'
config.scrollback_lines = 250000

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

-- config.font = wezterm.font('Source Han Code JP', { weight = 'Bold' })
-- config.font =  wezterm.font("HackGen Console NF", { weight="Bold", stretch="Normal", style="Normal" })
config.font = wezterm.font_with_fallback({
  -- user fonts
  {family="HackGen35 Console NF", weight="Bold", stretch="Normal", style="Normal"},
  -- <built-in>, BuiltIn
  {family="Menlo", weight="Regular", stretch="Normal", style="Normal"},
  -- <built-in>, BuiltIn
  "JetBrains Mono",
  -- <built-in>, BuiltIn
  -- Assumed to have Emoji Presentation
  "Noto Color Emoji",
  -- <built-in>, BuiltIn
  "Symbols Nerd Font Mono",
})

config.font_size = 13.0
local hostname = wezterm.hostname()
if (hostname == 'ayame.local') then
  config.font_size = 14
end

config.disable_default_key_bindings = true
config.leader = keybinds.leader
config.keys = keybinds.keys
config.key_tables = keybinds.key_tables

-- macos ime
config.macos_forward_to_ime_modifier_mask = 'SHIFT|CTRL'

wezterm.on('format-tab-title', on_format_tab_title)

return config
