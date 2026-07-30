local module = {}

function module.apply_to_config(config)
	config.use_dead_keys = false -- dead keys might cause problems in vim-like editors
	config.scrollback_lines = 5000
	config.hide_tab_bar_if_only_one_tab = true
	config.enable_scroll_bar = true
	config.adjust_window_size_when_changing_font_size = false
	config.color_scheme = "Tokyo Night"
	config.window_decorations = "RESIZE" -- disable window borders
	config.inactive_pane_hsb = {
		saturation = 0.8,
		brightness = 0.7,
	}
	config.window_background_opacity = 0.85
  config.enable_wayland=true
  config.use_fancy_tab_bar = true
end

return module
