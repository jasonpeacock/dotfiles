local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.default_prog = { "/Users/jpeacock/.nix-profile/bin/fish", "--login" }

config.color_scheme = "Gruvbox dark, soft (base16)"
config.font = wezterm.font("GoMono Nerd Font Mono")
-- config.font = wezterm.font("IosevkaTermSlab Nerd Font Mono", { weight = "Medium" })
config.font_size = 13.0

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

return config
