local wezterm = require("wezterm")

local config = {}

local platform_info = require("platform")()

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config = {
	use_dead_keys = false, -- dead keys might cause some problems in vim like editors
	scrollback_lines = 5000,
	hide_tab_bar_if_only_one_tab = true,
	enable_scroll_bar = true,
	adjust_window_size_when_changing_font_size = false,
	color_scheme = "Tokyo Night",
	window_decorations = "RESIZE", -- disable windows borders
	inactive_pane_hsb = { -- dim inactive tabs
		saturation = 0.8,
		brightness = 0.7,
	},
  window_background_opacity = 0.85
}

if platform_info.is_win then
	config.default_prog = { "pwsh" }
	config.default_cwd = "D:\\"
elseif platform_info.is_linux then
	--
end

--config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }
config.leader = { key = "n", mods = "CTRL", timeout_milliseconds = 2000 }

config.keys = require("bindings")

-- https://github.com/mikkasendke/sessionizer.wezterm
local sessionizer = wezterm.plugin.require "https://github.com/mikkasendke/sessionizer.wezterm"

local my_schema = {
  { label = "Some project", id = "~/dev/project" }, -- Custom entry, label is what you see. By default id is used as the path for a workspace.
  "Workspace 1",  -- Simple string entry, expands to { label = "Workspace 1", id = "Workspace 1" }
  sessionizer.DefaultWorkspace {},
  sessionizer.AllActiveWorkspaces {},
  sessionizer.FdSearch "/mnt/data/Projects/", -- Searches for git repos in ~/my_projects
}

config.keys = {
  { key = "S", mods = "LEADER", action = sessionizer.show(my_schema) },
}

return config
