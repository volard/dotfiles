-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
-- mode, hotkey, command, description
map("n", ";", ":", { desc = "Go to command mode" })
map("n", "C-n", "<cmd>Neotree toggle<CR>", { desc = "Toggle NeoTree" })
map("i", "C-n", "<cmd>Neotree toggle<CR>", { desc = "Toggle NeoTree" })
