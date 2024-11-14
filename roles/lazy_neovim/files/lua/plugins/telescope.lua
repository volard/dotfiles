-- change some telescope options and a keymap to browse plugin files
return
{
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      layout_config = { prompt_position = "top" }, -- search bar at the top
      sorting_strategy = "ascending", -- display results top->bottom
    },
  },
}
