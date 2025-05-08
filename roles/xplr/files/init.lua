---@diagnostic disable
local xplr = xplr -- The globally exposed configuration to be overridden.

--https://xplr.dev/en/post-install
version = "0.21.10"
---@diagnostic enable

local base = os.getenv('HOME')..'/.config/xplr/'

package.path =
	base..'?.lua;'..
	base..'?/init.lua;'..
	package.path

-- https://xplr.dev/en/general-config
require('general')

-- https://xplr.dev/en/node_types
require('nodetypes')

-- https://xplr.dev/en/layouts
require('layouts')

-- https://xplr.dev/en/modes
-- require('modes')

