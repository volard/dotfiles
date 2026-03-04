return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "bash",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "python",
      "query",
      "tsx",
      "typescript",
    },

    rainbow = {
      enable = true,
      disable = { "html" },
      extended_mode = false,
      max_file_lines = 1000,
    },
  },
}
