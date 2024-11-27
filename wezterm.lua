local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Gruvbox dark, soft (base16)'
config.font = wezterm.font {
	family = 'FiraCode Nerd Font Mono',
	weight = 'Regular',
	harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1'},
}

config.line_height = 1.1

config.hide_tab_bar_if_only_one_tab = true

config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 100,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 100,
}
config.colors = {
  visual_bell = '#202020',
}
config.audible_bell = "Disabled"

return config
