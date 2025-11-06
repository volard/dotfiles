-- change some telescope options and a keymap to browse plugin files
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "isak102/telescope-git-file-history.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "tpope/vim-fugitive",
      },
    },
    {
      "princejoogie/dir-telescope.nvim",
      config = function()
        require("dir-telescope").setup({
          hidden = true,
          no_ignore = false,
          show_preview = true,
          follow_symlinks = true,
        })
      end,
    },
  },
  keys = {
    { "<leader>fd", "<cmd>GrepInDirectory<CR>", desc = "Grep in dir" },
    { "<leader>pd", "<cmd>FileInDirectory<CR>", desc = "Find in dir" },
  },
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
        -- hijack_netrw = true,
        grouped = true,
        no_ignore = true,
        hidden = { file_browser = true, folder_browser = true },
        hide_parent_dir = true,
      },
    },
  },
}
