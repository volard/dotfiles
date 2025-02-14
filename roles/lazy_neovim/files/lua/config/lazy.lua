local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local ts_builtin = require('telescope.builtin')
    local function is_git_repo()
      vim.fn.system("git rev-parse --is-inside-work-tree")
      vim.print(vim.v.shell_error == 0)
      return vim.v.shell_error == 0
    end
    local function get_git_root()
      local dot_git_path = vim.fn.finddir(".git", ".;")
      return vim.fn.fnamemodify(dot_git_path, ":h")
    end
    local opts = {
        hidden = { file_browser = true, folder_browser = true },
        hide_parent_dir = true,
        show_untracked = true,
    }
    if is_git_repo() then
      opts = {
        cwd = get_git_root(),
        hidden = { file_browser = true, folder_browser = true },
        hide_parent_dir = true,
        show_untracked = true,
      }
      ts_builtin.git_files(opts)
    else
      ts_builtin.find_files(opts)
    end
  end,
})


require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
    },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "retrobox" } },
  checker = { enabled = false }, -- automatically check for plugin updates (it's annoying)
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
