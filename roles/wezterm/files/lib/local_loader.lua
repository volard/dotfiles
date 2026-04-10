local wezterm = require("wezterm")

local module = {}

local function config_file_path(relative_path)
	return wezterm.config_dir .. "/" .. relative_path
end

function module.load(relative_path)
	local chunk, err = loadfile(config_file_path(relative_path))
	if not chunk then
		error("Failed to load local module '" .. relative_path .. "': " .. tostring(err))
	end

	return chunk()
end

return module
