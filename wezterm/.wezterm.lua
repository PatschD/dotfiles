local wezterm = require 'wezterm';
local act = wezterm.action
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
  local _, _, window = mux.spawn_window(cmd or {})
  --[[ window:set_position(0, 0) ]]
  window:gui_window():set_position(300, 150)
end)

local copy_mode = nil

local keymaps = {
  { key = 'u', mods = 'CTRL', action = act.CopyMode 'PageUp' },
  { key = 'd', mods = 'CTRL', action = act.CopyMode 'PageDown' },
  --[[ { key = 'c', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection' }, ]]
}

if wezterm.gui then
  copy_mode = wezterm.gui.default_key_tables().copy_mode
  for _, keymap in ipairs(keymaps) do
    table.insert(
      copy_mode, keymap
    )
  end
end


return {
  send_composed_key_when_left_alt_is_pressed = true,
  -- font = wezterm.font("JetBrains Mono", { weight = "Regular" }),
  font = wezterm.font("Berkeley Mono", { weight = "Regular" }),
  -- line_height = 1.1,
  font_size = 15,
  -- font = wezterm.font("Comic Code", { weight = "Medium" }),
  -- window_decorations = "NONE"
  hide_tab_bar_if_only_one_tab = true,
  initial_cols = 100,
  initial_rows = 35,
  audible_bell = "Disabled",
  -- harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },

  window_padding = {
    left = 4,
    right = 4,
    top = 0,
    bottom = 0,
  },
  scrollback_lines = 9500,

  key_tables = {
    copy_mode = copy_mode,
  },

  force_reverse_video_cursor = true,
  -- color_scheme = "Catppuccin Mocha",   -- or Macchiato, Frappe, Latte
  color_scheme = 'Kanagawa (Gogh)',
}
