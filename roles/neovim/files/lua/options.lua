local o = vim.opt
local g = vim.g

-- disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

------------------------------------------------------------------------
--                          custom variables                          --
------------------------------------------------------------------------
--g.is_win = (utils.has("win32") or utils.has("win64")) and true or false
--g.is_linux = (utils.has("unix") and (not utils.has("macunix"))) and true or false
--g.is_mac  = utils.has("macunix") and true or false

g.logging_level = "info"
------------------------------------------------------------------------
g.mapleader = " "
g.maplocalleader = "\\"


-- Hint: use `:h <option>` to figure out the meaning if needed
o.clipboard = 'unnamedplus'   -- use system clipboard 
o.completeopt = {'menu', 'menuone', 'noselect'}
o.mouse = 'a'                 -- allow the mouse to be used in Nvim

-- Tab
o.tabstop = 4                 -- number of visual spaces per TAB
o.softtabstop = 4             -- number of spacesin tab when editing
o.shiftwidth = 4              -- insert 4 spaces on a tab
o.expandtab = true            -- tabs are spaces, mainly because of python

-- UI config
o.number = false              -- show absolute number
o.relativenumber = false      -- add numbers to each line on the left side
o.cursorline = false          -- highlight cursor line underneath the cursor horizontally
o.splitbelow = true           -- open new vertical split bottom
o.splitright = true           -- open new horizontal splits right
o.termguicolors = true        -- enable 24-bit RGB color in the TUI

-- Searching
o.incsearch = true            -- search as characters are entered
o.hlsearch = false            -- do not highlight matches
o.ignorecase = true           -- ignore case in searches by default
o.smartcase = true            -- but make it case sensitive if an uppercase is entered