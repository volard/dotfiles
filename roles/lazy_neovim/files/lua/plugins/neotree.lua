return {
  "nvim-neo-tree/neo-tree.nvim",

  keys = {
    -- { "<leader>e", desc = "Explorer NeoTree (Root Dir)", remap = true },
    { "<leader>E", desc = "Explorer NeoTree (cwd)", remap = true },
    { '<leader>e', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } }
  },

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  lazy = false, -- neo-tree will lazily load itself
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
    filesystem = {
      hijack_netrw_behavior = "open_current", -- netrw disabled, opening a directory opens neo-tree
      -- in whatever position is specified in window.position
      -- "open_current",  -- netrw disabled, opening a directory opens within the
      -- window like netrw would, regardless of window.position
      -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
      filtered_items = {
        visible = true,
        always_show = { -- remains visible even if other settings would normally hide it
          ".gitignore",
        },
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          ".git",
          ".DS_Store",
          "thumbs.db",
          "node_modules",
        },
        never_show = {},
      },
    },
  },
}
