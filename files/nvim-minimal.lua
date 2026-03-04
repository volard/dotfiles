-- Requirement check
if vim.fn.has("nvim-0.8") == 0 then
	print("Neovim >= v0.8 is required for this config")
	return
end

-- Bootstrap lazy.nvim
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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{
			"folke/flash.nvim",
			event = "VeryLazy",
			---@type Flash.Config
			opts = {},
			keys = {
				{
					"s",
					mode = { "n", "x", "o" },
					function()
						require("flash").jump()
					end,
					desc = "Flash",
				},
				{
					"S",
					mode = { "n", "x", "o" },
					function()
						require("flash").treesitter()
					end,
					desc = "Flash Treesitter",
				},
				{
					"r",
					mode = "o",
					function()
						require("flash").remote()
					end,
					desc = "Remote Flash",
				},
				{
					"R",
					mode = { "o", "x" },
					function()
						require("flash").treesitter_search()
					end,
					desc = "Treesitter Search",
				},
				{
					"<c-s>",
					mode = { "c" },
					function()
						require("flash").toggle()
					end,
					desc = "Toggle Flash Search",
				},
			},
		},
    -- Auto Pairs
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },
		-- File Tree
		{
			"nvim-tree/nvim-tree.lua",
			version = "*",
			lazy = false,
			keys = { { "<leader>e", "<cmd>NvimTreeToggle<cr>" } },
			dependencies = {
				"nvim-tree/nvim-web-devicons",
			},
			config = function()
				require("nvim-tree").setup({})
			end,
		},
		-- Telescope
		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.8",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				local builtin = require("telescope.builtin")

				-- Example keymaps
				vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
				vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
				vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
				vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
			end,
		},
		{
			"navarasu/onedark.nvim",
			lazy = false,
			priority = 1000,
			config = function()
				require("onedark").setup({
					-- Add your configuration options here if needed
					style = "dark", -- Options: 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'
					transparent = false, -- Enable transparent background
					term_colors = true, -- Enable terminal colors
					ending_tildes = false, -- Show end of buffer tildes
					cmp_itemkind_reverse = false, -- Reverse item kind highlights in cmp

					-- Custom highlights
					colors = {}, -- Override default colors
					highlights = {}, -- Override highlight groups

					-- Plugins Config
					diagnostics = {
						darker = true, -- darker colors for diagnostic
						undercurl = true, -- use undercurl for diagnostics
						background = true, -- use background color for virtual text
					},
				})
				vim.cmd("colorscheme onedark")
			end,
		},
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

-- Hint: use `:h <option>` to figure out the meaning if needed
vim.opt.clipboard = "unnamedplus" -- use system clipboard
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.mouse = "a" -- allow the mouse to be used in nvim

-- Tab
vim.opt.tabstop = 4 -- number of visual spaces per TAB
vim.opt.softtabstop = 4 -- number of spaces in tab when editing
vim.opt.shiftwidth = 4 -- insert 4 spaces on a tab
vim.opt.expandtab = true -- tabs are spaces, mainly because of Python

-- UI config
vim.opt.number = true -- show absolute number
vim.opt.cursorline = true -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true -- open new vertical split bottom
vim.opt.splitright = true -- open new horizontal splits right
vim.opt.termguicolors = true -- enable 24-bit RGB color in the TUI
vim.opt.scrolloff = 8
vim.opt.smartindent = true

-- Searching
vim.opt.incsearch = true -- search as characters are entered
vim.opt.hlsearch = false -- do not highlight matches
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true -- but make it case sensitive if an uppercase is entered

-- define common options
local opts = {
	noremap = true, -- non-recursive
	silent = true, -- do not show message
}


-- Filetype-specific indentation
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact", "css", "html", "json", "yaml", "lua", "markdown" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "cpp", "c", "java", "go", "rust", "php", "sh", "zsh" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- Fallback for all other filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    if vim.bo.shiftwidth == 0 then -- Only set if not already set
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.softtabstop = 4
    end
  end,
})

-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
