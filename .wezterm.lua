local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.default_prog = { "/Users/jpeacock/.nix-profile/bin/fish", "--login" }

config.color_scheme = "Solarized (dark) (terminal.sexy)"
-- config.font = wezterm.font("GoMono Nerd Font Mono")
config.font = wezterm.font("IosevkaTermSlab Nerd Font Mono")
config.font_size = 14.0

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

return config
