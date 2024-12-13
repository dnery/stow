local wezterm = require 'wezterm'
local config = {}
-- local config = wezterm.config_builder()

-- DO MORE CONFIG HERE

-- Colors and font
-- config.font = wezterm.font 'Jetbrains Mono'
config.color_scheme = 'Solarized Dark Higher Contrast'

-- Remove annoying update banners
config.check_for_updates = false

-- Compositing options
config.window_background_opacity = 0.75

return config
