-- change some telescope options and a keymap to browse plugin files
return {
  "nvim-telescope/telescope.nvim",
  opts = {
    theme = "catppuccin",
    defaults = {
      file_ignore_patterns = { "^./.git/", "^node_modules/", "^vendor/" },
      layout_config = { prompt_position = "top" }, -- search bar at the top
      sorting_strategy = "ascending", -- display results top->bottom
      history = {
        path = vim.fn.stdpath("data") .. "/telescope_history",
        limit = 100, -- Limit the number of history entries
      },
    },
    extensions = {
      file_browser = {
        hijack_netrw = true,
        grouped = true,
        no_ignore = true,
        hidden = { file_browser = true, folder_browser = true },
        hide_parent_dir = true,
      },
    },
  },
}
