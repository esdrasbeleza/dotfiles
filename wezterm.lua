local wezterm = require 'wezterm'

local config = wezterm.config_builder()

local is_linux = function()
  return wezterm.target_triple:find("linux") ~= nil
end

local is_darwin = function()
  return wezterm.target_triple:find("darwin") ~= nil
end

config.color_scheme = 'terafox'

-- Configure fonts
local fonts = {
  {
    family = 'FiraCode Nerd Font Mono',
    weight = 'Regular',
    harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
    assume_emoji_presentation = false,
  }
}
if is_darwin then
  table.insert(fonts, {
    family = 'Apple Color Emoji',
    assume_emoji_presentation = true,
    style = 'Normal',
    weight = 'Regular',
    stretch = 'Normal'
  })
end
config.font = wezterm.font_with_fallback(fonts)


config.line_height = 1.1

config.font_size = 18.0

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

if is_linux then
  config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
  config.integrated_title_buttons = { 'Hide', 'Maximize', 'Close' }
end

if is_darwin then
  config.hide_tab_bar_if_only_one_tab = true
end

config.window_frame = {
  font = wezterm.font({ family = 'FiraCode Nerd Font Mono' }),
  font_size = 14,
}

config.command_palette_font_size = 20
config.command_palette_rows = 30

config.use_fancy_tab_bar = true
config.window_background_opacity = 0.93
config.macos_window_background_blur = 55

return config
