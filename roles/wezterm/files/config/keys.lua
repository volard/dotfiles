local wezterm = require("wezterm")
local local_loader = dofile(wezterm.config_dir .. "/lib/local_loader.lua")
local key_utils = local_loader.load("lib/key_utils.lua")

local module = {}

function module.apply_to_config(config)
	config.leader = { key = "n", mods = "CTRL", timeout_milliseconds = 2000 }
	key_utils.append_keys(config, local_loader.load("bindings.lua"))
end

return module
