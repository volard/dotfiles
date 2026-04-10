local wezterm = require("wezterm")
local local_loader = dofile(wezterm.config_dir .. "/lib/local_loader.lua")

local module = {}

local plugin_files = {
	"plugins/sessionizer.lua",
}

function module.apply_to_config(config)
	for _, plugin_file in ipairs(plugin_files) do
		local ok, plugin = pcall(local_loader.load, plugin_file)
		if not ok then
			wezterm.log_error("Failed to load plugin file " .. plugin_file .. ": " .. tostring(plugin))
		elseif type(plugin) == "table" and type(plugin.apply_to_config) == "function" then
			plugin.apply_to_config(config)
		elseif type(plugin) == "function" then
			plugin(config)
		else
			wezterm.log_error(
				"Plugin file "
					.. plugin_file
					.. " must return { apply_to_config = function(config) ... } or function(config), got "
					.. type(plugin)
			)
		end
	end
end

return module
