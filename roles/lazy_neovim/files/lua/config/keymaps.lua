-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
-- mode, hotkey, command, description
map("n", ";", ":", { desc = "Go to command mode" })
map("i", "<C-i>", "<esc>", { desc = "Go to normal mode" })
map("n", "<C-p>", "\"0p", { desc = 'Paste last copyed "0 regester content' })

-- map("n", "<C-u>", "<C-u>zz", { desc = 'Center on page up half way' })
-- map("n", "<C-d>", "<C-d>zz", { desc = 'Center on page up half way' })

map("v", "<C-p>", "\"0p", { desc = 'Paste last copyed "0 regester content' })
map("n", "<space>fb", "<cmd>Telescope file_browser<CR>", { desc = "Open file browser" })
