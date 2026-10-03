local wezterm = require("wezterm")
local local_loader = dofile(wezterm.config_dir .. "/lib/local_loader.lua")
local platform_info = local_loader.load("platform.lua")()

local module = {}

function module.apply_to_config(config)
	if platform_info.is_win then
		config.default_prog = { "pwsh" }
		config.default_cwd = "D:\\"
	elseif platform_info.is_linux then
		if os.getenv("NIRI_SOCKET") then
			config.window_decorations = "TITLE|RESIZE"
		end
	end
end

return module
