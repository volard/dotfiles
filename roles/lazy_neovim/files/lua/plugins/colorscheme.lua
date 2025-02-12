return {
  "catppuccin/nvim",
  opts = {
    telescope = {
      enabled = true,
    },
    default_integrations = true,
    integrations = {
      harpoon = false,
      lsp_saga = false,
      noice = true,
      telescope = {
        enabled = true,
      },
    },
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    color_overrides = {
      all = {
        base = "#080808",
      },
    },
    dim_inactive = {
      enabled = true,
    },
  },
}
