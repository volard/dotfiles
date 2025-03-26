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
      "markdown_inline",
      "python",
      "query",
      "regex",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    },

    rainbow = {
      enable = true,
      disable = { "html" },
      extended_mode = false,
      max_file_lines = 1000,
    },
  },
}
