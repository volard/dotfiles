--                          config for nvim-qt
-- To check if neovim-qt is running, use `exists('g:GuiLoaded')`,
-- see https://github.com/equalsraf/neovim-qt/issues/219
if vim.g.GuiLoaded then
  -- call GuiWindowMaximized(1)
  vim.g.GuiTabline = 0
  vim.g.GuiPopupmenu = 0
  vim.g.GuiLinespace = 2
end

--                             config for neovide
if vim.g.neovide then
  vim.g.neovide_transparency = 1.0
  vim.g.neovide_cursor_animation_length = 0.1
  vim.g.neovide_cursor_trail_size = 0.3
  vim.g.neovide_cursor_vfx_mode = ""
  vim.g.neovide_cursor_vfx_particle_density = 10.0
  vim.g.neovide_cursor_vfx_opacity = 150.0
  vim.g.neovide_hide_mouse_when_typing = true
  -- vim.g.neovide_underline_automatic_scaling = true -- Noticeable for font sizes above 15
end

local font_size = 14
-- vim.o.guifont = 'JetBrains Mono Nerd Font Mono' .. ':h' .. font_size
vim.o.guifont = "JetBrains Mono" .. ":h" .. font_size

-- Fix key mapping issues for GUI
vim.api.nvim_set_keymap("i", "<S-Insert>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "<S-Insert>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-6>", "<C-^>", { noremap = true, silent = true })
