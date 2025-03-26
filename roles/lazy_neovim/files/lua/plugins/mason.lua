return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "stylua",
      "shellcheck",
      "shfmt",
      "docker-compose-language-service",
      "dockerfile-language-server",
      "hadolint",
      "flake8",
    },
  },
}
