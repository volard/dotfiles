local wezterm = require("wezterm")
local local_loader = dofile(wezterm.config_dir .. "/lib/local_loader.lua")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

local modules = {
	local_loader.load("config/options.lua"),
	local_loader.load("config/platform.lua"),
	local_loader.load("config/keys.lua"),
	local_loader.load("plugins/init.lua"),
}

for _, module in ipairs(modules) do
	module.apply_to_config(config)
end

return config
