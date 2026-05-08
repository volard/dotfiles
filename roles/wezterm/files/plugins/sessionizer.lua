local wezterm = require("wezterm")
local local_loader = dofile(wezterm.config_dir .. "/lib/local_loader.lua")
local key_utils = local_loader.load("lib/key_utils.lua")

local module = {}
local sessionizer = wezterm.plugin.require("https://github.com/mikkasendke/sessionizer.wezterm")

local function dir_exists(path)
	local ok, _, code = os.rename(path, path)
	if ok then
		return true
	end

	return code == 13
end

local function add_unique_dir(result, seen, path)
	if not path or path == "" or not dir_exists(path) or seen[path] then
		return
	end

	seen[path] = true
	table.insert(result, path)
end

local function read_lines(path)
	local file = io.open(path, "r")
	if not file then
		return {}
	end

	local lines = {}
	for line in file:lines() do
		if line ~= "" and not line:match("^%s*#") then
			table.insert(lines, line:gsub("^~", os.getenv("HOME") or "~"))
		end
	end

	file:close()
	return lines
end

local function detect_project_roots()
	local home = os.getenv("HOME")
	local config_dir = os.getenv("XDG_CONFIG_HOME") or (home and (home .. "/.config"))
	local root_dirs_file = os.getenv("TSESH_ROOT_DIRS_FILE") or (config_dir and (config_dir .. "/tsesh/root-dirs"))
	local roots = {}
	local seen = {}

	if root_dirs_file then
		for _, path in ipairs(read_lines(root_dirs_file)) do
			add_unique_dir(roots, seen, path)
		end
	end

	add_unique_dir(roots, seen, os.getenv("TSESH_PROJECTS_DIR"))
	add_unique_dir(roots, seen, home and (home .. "/projects") or nil)
	add_unique_dir(roots, seen, home and (home .. "/Projects") or nil)
	add_unique_dir(roots, seen, "/mnt/data/Projects")

	return roots
end

local schema = {
	{ label = "Some project", id = "~/dev/project" }, -- label is shown in picker; id is the workspace path/name
	"Workspace 1",
	sessionizer.DefaultWorkspace {},
	sessionizer.AllActiveWorkspaces {},
}

for _, root in ipairs(detect_project_roots()) do
	table.insert(schema, sessionizer.FdSearch(root))
end

function module.apply_to_config(config)
	key_utils.append_keys(config, {
		{ key = "S", mods = "LEADER", action = sessionizer.show(schema) },
	})
end

return module
