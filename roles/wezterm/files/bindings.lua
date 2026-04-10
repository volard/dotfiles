local wezterm = require("wezterm")
local act = wezterm.action

return {
	{ key = "x", mods = "CTRL", action = act.CloseCurrentPane({ confirm = false }) },
	{ key = "l", mods = "LEADER", action = wezterm.action.ShowLauncher },

	-- Navigate between panes
	{
    -- key = "LeftArrow",
		key = "h",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection "Left",
	},
	{
		-- key = "RightArrow",
    key = "l",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection "Right",
	},
	{
		--key = "UpArrow",
    key="k",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection "Up",
	},
	{
		-- key = "DownArrow",
		key = "j",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection "Down",
	},


	-- panes: navigation
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

	-- Splits
	{
		key = "s",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	-- rename tab title
	{
		key = "r",
		mods = "CTRL|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

  -- https://wezterm.org/config/default-keys.html
  -- CTRL+SHIFT+T       spawn new tab
  -- CTRL+SHIFT+W       close current tab
  -- CTRL+SHIFT+<num>   activate <num> tab
  -- CTRL+[SHIFT]+TAB   cycle tabs
  -- CTRL+SHIFT+UP|DOWN cycle tabs
  -- CTRL+SHIFT+L       show debug
  -- CTRL+SHIFT+P       command palette
  -- CTRL+SHIFT+U       char selector
  -- CTRL+SHIFT+F       search
  -- CTRL+SHIFT+N       new window
  -- CTRL+SHIFT+X       copy mode
}
