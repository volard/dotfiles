---@diagnostic disable
local xplr = xplr -- The globally exposed configuration to be overridden.

--https://xplr.dev/en/post-install
version = "0.21.10"
---@diagnostic enable

-- package manager
local home = os.getenv("HOME")
local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
local xpm_url = "https://github.com/dtomvan/xpm.xplr"
local xplr_config_path = home..'/.config/xplr/'

package.path = package.path .. ";"
  .. xpm_path .. "/?.lua;"
  .. xpm_path .. "/?/init.lua;"
  .. xplr_config_path .. '?.lua;'
  .. xplr_config_path .. "/plugins/?/init.lua;"
  .. home
  .. xplr_config_path .. "/plugins/?.lua;"

os.execute(
  string.format(
    "[ -e '%s' ] || git clone '%s' '%s'",
    xpm_path,
    xpm_url,
    xpm_path
  )
)

require('icons').setup()

require("xpm").setup({
  'dtomvan/xpm.xplr',

  'gitlab:hartan/web-devicons.xplr',
  {
    'dtomvan/extra-icons.xplr',
    after = function()
      xplr.config.general.table.row.cols[2] = { format = "custom.icons_dtomvan_col_1" }
    end
  },
})


-- https://xplr.dev/en/general-config
require('general')

-- https://xplr.dev/en/node_types

-- https://xplr.dev/en/layouts
require('layouts')

-- https://xplr.dev/en/modes
-- require('modes')

