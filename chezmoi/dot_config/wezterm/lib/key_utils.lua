local module = {}

function module.append_keys(config, keys)
	if type(keys) ~= "table" then
		return
	end

	config.keys = config.keys or {}

	for _, key in ipairs(keys) do
		table.insert(config.keys, key)
	end
end

return module
