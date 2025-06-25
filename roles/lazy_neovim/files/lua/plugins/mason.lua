return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "tinymist",
      "stylua",
      "shellcheck",
      "shfmt",
      "docker-compose-language-service",
      "dockerfile-language-server",
      "hadolint",
    },
  },
}
