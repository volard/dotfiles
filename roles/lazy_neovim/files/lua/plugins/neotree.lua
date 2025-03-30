return {
  "nvim-neo-tree/neo-tree.nvim",

  keys = {
    { "<leader>E", ":Neotree focus reveal current<CR>", desc = "Explorer NeoTree (cwd)", remap = true },
    { "<leader>e", ":Neotree toggle current reveal_force_cwd<cr>", desc = "NeoTree focus current", remap = true },
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
    default_component_configs = {
      file_size = { enabled = false },
      type = { enabled = false },
      last_modified = { enabled = false },
      created = { enabled = false },
    },
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
        always_show_by_pattern = {
          "*.env*"
        }, -- remains visible even if other settings would normally hide it
        hide_by_pattern = {

        },
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = true,
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
