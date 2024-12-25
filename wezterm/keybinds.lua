local wezterm = require 'wezterm'
local act = wezterm.action

return {
  leader = { key = "t", mods = "CTRL", timeout_milliseconds = 2000 },
  keys = {
    { key = "t", mods = "CTRL|LEADER", action = wezterm.action{SendString="\x14"} },
    { key = 'Enter', mods = 'ALT', action = act.ToggleFullScreen },

    { key = '1', mods = 'LEADER', action = act.ActivateTab(0) },
    { key = '2', mods = 'LEADER', action = act.ActivateTab(1) },
    { key = '3', mods = 'LEADER', action = act.ActivateTab(2) },
    { key = '4', mods = 'LEADER', action = act.ActivateTab(3) },
    { key = '5', mods = 'LEADER', action = act.ActivateTab(4) },
    { key = '6', mods = 'LEADER', action = act.ActivateTab(5) },
    { key = '7', mods = 'LEADER', action = act.ActivateTab(6) },
    { key = '8', mods = 'LEADER', action = act.ActivateTab(7) },
    { key = '9', mods = 'LEADER', action = act.ActivateTab(-1) },

    { key = 'c', mods = 'SUPER', action = act.CopyTo 'Clipboard' },
    { key = 'v', mods = 'SUPER', action = act.PasteFrom 'Clipboard' },
    { key = 'p', mods = 'SUPER|SHIFT', action = act.ActivateCommandPalette },
    { key = 'f', mods = 'SUPER', action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = 'h', mods = 'SUPER', action = act.HideApplication },
    { key = 'm', mods = 'SUPER', action = act.Hide },
    { key = 'q', mods = 'SUPER', action = wezterm.action.QuitApplication },
    { key = 'phys:Space', mods = 'LEADER', action = act.ActivateCopyMode },
    --{ key = 'phys:Space', mods = 'LEADER|CTRL', action = act.QuickSelect },
    { key = 'k', mods = 'SUPER', action = act.ClearScrollback 'ScrollbackOnly' },
    { key = 'k', mods = 'SUPER|ALT', action = act.ClearScrollback 'ScrollbackAndViewport' },

    { key = 'PageUp', action = act.ScrollByPage(-1) },
    { key = 'PageDown', action = act.ScrollByPage(1) },

    -- font size
    { key = '0', mods = 'SUPER', action = act.ResetFontSize },
    { key = '=', mods = 'SUPER', action = act.IncreaseFontSize },
    { key = '-', mods = 'SUPER', action = act.DecreaseFontSize },

    -- tab
    { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'x', mods = 'LEADER', action = act.CloseCurrentTab{ confirm = true } },
    { key = 'l', mods = 'LEADER|CTRL', action = act.ActivateTabRelative(1) },
    { key = 'h', mods = 'LEADER|CTRL', action = act.ActivateTabRelative(-1) },

    -- panel move
    { key = '\\', mods = 'LEADER', action = act.SplitHorizontal {domain = 'CurrentPaneDomain'} },
    { key = '-', mods = 'LEADER', action = act.SplitVertical {domain = 'CurrentPaneDomain'} },
    { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
    { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },
    { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
    { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },

    -- panel resize
    { key = 'h', mods = 'LEADER|SHIFT', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false } },
    { key = 'l', mods = 'LEADER|SHIFT', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false } },
    { key = 'k', mods = 'LEADER|SHIFT', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false } },
    { key = 'j', mods = 'LEADER|SHIFT', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false } },
  },

  key_tables = {
    copy_mode = {
      { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
      { key = 'c', mods = 'CTRL', action = act.CopyMode 'Close' },
      { key = 'g', mods = 'CTRL', action = act.Multiple{ { CopyMode = 'ClearPattern' }, { CopyMode = 'Close' } } },
      { key = '/', mods = 'NONE', action = act.Search 'CurrentSelectionOrEmptyString' },
      -- copy
      { key = 'y', mods = 'NONE', action = act.Multiple{ { CopyTo = 'ClipboardAndPrimarySelection' }, { CopyMode = 'Close' } } },
      -- search
      { key = 'n', mods = 'CTRL', action = act.CopyMode 'NextMatch' },
      { key = 'p', mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
      -- selection
      { key = 'v', mods = 'NONE', action = act.CopyMode{ SetSelectionMode = 'Cell' } },
      { key = 'v', mods = 'SHIFT', action = act.CopyMode{ SetSelectionMode = 'Line' } },
      { key = 'v', mods = 'CTRL', action = act.CopyMode{ SetSelectionMode = 'Block' } },
      -- move page
      { key = 'g', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackTop' },
      { key = 'g', mods = 'SHIFT', action = act.CopyMode 'MoveToScrollbackBottom' },
      { key = 'u', mods = 'NONE', action = act.CopyMode{ MoveByPage = (-0.5) } },
      { key = 'u', mods = 'CTRL', action = act.CopyMode{ MoveByPage = (-1) } },
      { key = 'd', mods = 'NONE', action = act.CopyMode{ MoveByPage = (0.5) } },
      { key = 'd', mods = 'CTRL', action = act.CopyMode{ MoveByPage = (1) } },
      { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PageUp' },
      { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'PageDown' },
      -- move line
      { key = '0', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
      { key = '$', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = 'Home', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
      { key = 'End', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
      -- move word
      { key = 'e', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
      { key = 'b', mods = 'NONE', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'w', mods = 'NONE', action = act.CopyMode 'MoveForwardWordEnd' },
      -- move
      { key = 'h', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
      { key = 'j', mods = 'NONE', action = act.CopyMode 'MoveDown' },
      { key = 'k', mods = 'NONE', action = act.CopyMode 'MoveUp' },
      { key = 'l', mods = 'NONE', action = act.CopyMode 'MoveRight' },
      { key = 'LeftArrow', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'MoveDown' },
      { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'MoveUp' },
      { key = 'RightArrow', mods = 'NONE', action = act.CopyMode 'MoveRight' },
    },

    search_mode = {
      { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
      { key = 'c', mods = 'CTRL', action = act.CopyMode 'Close' },
      { key = 'g', mods = 'CTRL', action = act.Multiple{ { CopyMode = 'ClearPattern' }, { CopyMode = 'Close' } } },
      { key = 's', mods = 'CTRL', action = act.ActivateCopyMode },
      { key = 'Enter', mods = 'NONE', action = act.ActivateCopyMode },
      { key = 'n', mods = 'CTRL', action = act.CopyMode 'NextMatch' },
      { key = 'p', mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
      { key = 'r', mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
      { key = 'u', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
    },

    resize_pane = {
      { key = 'Escape', action = 'PopKeyTable' },
      { key = 'Enter', action = 'PopKeyTable' },
      { key = 'c', mode = 'CTRL', action = 'PopKeyTable' },
      { key = 'g', mode = 'CTRL', action = 'PopKeyTable' },
      { key = 'h', mods = 'NONE', action = act.AdjustPaneSize { 'Left', 10 } },
      { key = 'l', mods = 'NONE', action = act.AdjustPaneSize { 'Right', 10 } },
      { key = 'k', mods = 'NONE', action = act.AdjustPaneSize { 'Up', 10 } },
      { key = 'j', mods = 'NONE', action = act.AdjustPaneSize { 'Down', 10 } },
    }
  }
}
