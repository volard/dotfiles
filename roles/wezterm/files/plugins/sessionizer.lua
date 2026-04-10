local wezterm = require("wezterm")
local local_loader = dofile(wezterm.config_dir .. "/lib/local_loader.lua")
local key_utils = local_loader.load("lib/key_utils.lua")

local module = {}
local sessionizer = wezterm.plugin.require("https://github.com/mikkasendke/sessionizer.wezterm")

local schema = {
	{ label = "Some project", id = "~/dev/project" }, -- label is shown in picker; id is the workspace path/name
	"Workspace 1",
	sessionizer.DefaultWorkspace {},
	sessionizer.AllActiveWorkspaces {},
	sessionizer.FdSearch "/mnt/data/Projects/", -- search git repositories in this directory
}

function module.apply_to_config(config)
	key_utils.append_keys(config, {
		{ key = "S", mods = "LEADER", action = sessionizer.show(schema) },
	})
end

return module
