-- Pull in the wezterm API
local wezterm = require "wezterm"

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config = {
  color_scheme = "Gruvbox Dark (Gogh)",

  font = wezterm.font "MesloLGS Nerd Font Mono",
  -- font = wezterm.font "JetBrainsMono Nerd Font",
  font_size = 14.5,

  enable_wayland = false,
  enable_tab_bar = false,
  window_close_confirmation = "NeverPrompt",
  default_cursor_style = "SteadyBlock",
  window_padding = {
    left = 2,
    right = 2,
    top = 15,
    bottom = 0,
  },

  -- config.window_decorations = "RESIZE"
  window_background_opacity = 0.95,
  macos_window_background_blur = 20,
  max_fps = 120,
}

-- and finally, return the configuration to wezterm
return config
