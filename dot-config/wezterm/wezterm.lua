local wezterm = require 'wezterm'
local config = wezterm.config_builder() 

config.font = wezterm.font_with_fallback({
	'lilex', 'JetBrains Mono', 'Symbols Nerd Font'
})

return config
