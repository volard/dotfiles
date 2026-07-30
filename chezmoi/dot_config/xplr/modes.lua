---@diagnostic disable
local xplr = xplr -- The globally exposed configuration to be overridden.
---@diagnostic enable

-- ### Modes ------------------------------------------------------------------
--
-- xplr is a modal file explorer. That means the users switch between different
-- modes, each containing a different set of key bindings to avoid clashes.
-- Users can switch between these modes at run-time.
--
-- The modes can be configured using the `xplr.config.modes` Lua API.
--
-- `xplr.config.modes.builtin` contain some built-in modes which can be
-- overridden, but you can't add or remove modes in it.

-- The builtin default mode.
-- Visit the [Default Key Bindings](https://xplr.dev/en/default-key-bindings)
-- to see what each mode does.

-- This is where you define custom modes.
--
-- Type: mapping of the following key-value pairs:
--
-- * key: string
-- * value: [Mode](https://xplr.dev/en/mode)
--
-- Example:
--
-- ```lua
-- xplr.config.modes.custom.example = {
--   name = "example",
--   key_bindings = {
--     on_key = {
--       enter = {
--         help = "default mode",
--         messages = {
--           "PopMode",
--           { SwitchModeBuiltin = "default" },
--         },
--       },
--     },
--   },
-- }
--
-- xplr.config.general.initial_mode = "example"
-- ```
xplr.config.modes.custom = {}

-- ## Function ----------------------------------------------------------------
--
-- While `xplr.config` defines all the static parts of the configuration,
-- `xplr.fn` defines all the dynamic parts using functions.
--
-- See: [Lua Function Calls](https://xplr.dev/en/lua-function-calls)
--
-- As always, `xplr.fn.builtin` is where the built-in functions are defined
-- that can be overwritten.


-- This is where the custom functions can be added.
--
-- There is currently no restriction on what kind of functions can be defined
-- in `xplr.fn.custom`.
--
-- You can also use nested tables such as
-- `xplr.fn.custom.my_plugin.my_function` to define custom functions.
xplr.fn.custom = {}

-- ## Hooks -------------------------------------------------------------------
--
-- This section of the configuration cannot be overwritten by another config
-- file or plugin, since this is an optional lua return statement specific to
-- each config file. It can be used to define things that should be explicit
-- for reasons like performance concerns, such as hooks.
--
-- Plugins should expose the hooks, and require users to subscribe to them
-- explicitly.
--
-- Example:
--
-- ```lua
-- return {
--   -- Add messages to send when the xplr loads.
--   -- This is similar to the `--on-load` command-line option.
--   --
--   -- Type: list of [Message](https://xplr.dev/en/message#message)s
--   on_load = {
--     { LogSuccess = "Configuration successfully loaded!" },
--     { CallLuaSilently = "custom.some_plugin_with_hooks.on_load" },
--   },
--
--   -- Add messages to send when the directory changes.
--   --
--   -- Type: list of [Message](https://xplr.dev/en/message#message)s
--   on_directory_change = {
--     { LogSuccess = "Changed directory" },
--     { CallLuaSilently = "custom.some_plugin_with_hooks.on_directory_change" },
--   },
--
--   -- Add messages to send when the focus changes.
--   --
--   -- Type: list of [Message](https://xplr.dev/en/message#message)s
--   on_focus_change = {
--     { LogSuccess = "Changed focus" },
--     { CallLuaSilently = "custom.some_plugin_with_hooks.on_focus_change" },
--   }
--
--   -- Add messages to send when the mode is switched.
--   --
--   -- Type: list of [Message](https://xplr.dev/en/message#message)s
--   on_mode_switch = {
--     { LogSuccess = "Switched mode" },
--     { CallLuaSilently = "custom.some_plugin_with_hooks.on_mode_switch" },
--   }
--
--   -- Add messages to send when the layout is switched
--   --
--   -- Type: list of [Message](https://xplr.dev/en/message#message)s
--   on_layout_switch = {
--     { LogSuccess = "Switched layout" },
--     { CallLuaSilently = "custom.some_plugin_with_hooks.on_layout_switch" },
--   }
--
--   -- Add messages to send when the selection changes
--   --
--   -- Type: list of [Message](https://xplr.dev/en/message#message)s
--   on_selection_change = {
--     { LogSuccess = "Selection changed" },
--     { CallLuaSilently = "custom.some_plugin_with_hooks.on_selection_change" },
--   }
-- }
-- ```

return {
  on_load = {},
  on_directory_change = {},
  on_focus_change = {},
  on_mode_switch = {},
  on_layout_switch = {},
}

-- ----------------------------------------------------------------------------
-- > Note:
-- >
-- > It's not recommended to copy the entire configuration, unless you want to
-- > freeze it and miss out on useful updates to the defaults.
-- >
-- > Instead, you can use this as a reference to overwrite only the parts you
-- > want to update.
-- >
-- > If you still want to copy the entire configuration, make sure to put your
-- > customization before the return statement.
