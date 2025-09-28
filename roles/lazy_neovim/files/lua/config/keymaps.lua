-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
-- mode, hotkey, command, description

-- ; is used for F/T command
-- map("n", ";", ":", { desc = "Go to command mode" })
map("i", "<C-i>", "<esc>", { desc = "Go to normal mode" })

map("n", "<C-p>", '"0p', { desc = 'Paste last copyed "0 regester content' })
map("v", "<C-p>", '"0p', { desc = 'Paste last copyed "0 regester content' })

-- map("n", "<space>fb", "<cmd>Telescope file_browser<CR>", { desc = "Open file browser" })

-- https://miguelcrespo.co/posts/using-telescope-to-find-text-inside-paths
if vim.g.vscode then
    -- VSCode extension
else
  -- ordinary Neovim
  map("n", "<leader>fs", require("telescope").extensions.live_grep_args.live_grep_args, { noremap = true })
end



map("n", "й", "q")
map("n", "ц", "d")
map("n", "у", "r")
map("n", "к", "w")
map("n", "е", "b")
map("n", "н", "j")
map("n", "г", "f")
map("n", "ш", "u")
map("n", "щ", "p")
map("n", "з", ";")
map("n", "х", "[")
map("n", "ъ", "]")
map("n", "ф", "a")
map("n", "ы", "s")
map("n", "в", "h")
map("n", "а", "t")
map("n", "п", "g")
map("n", "р", "y")
map("n", "о", "n")
map("n", "л", "e")
map("n", "д", "o")
map("n", "ж", "i")
map("n", "э", "'")
map("n", "я", "z")
map("n", "ч", "x")
map("n", "с", "m")
map("n", "м", "c")
map("n", "и", "v")
map("n", "т", "k")
map("n", "ь", "l")
map("n", "б", ",")
map("n", "ю", ".")


map("n", "Й", "Q")
map("n", "Ц", "D")
map("n", "У", "R")
map("n", "К", "W")
map("n", "Е", "B")
map("n", "Н", "J")
map("n", "Г", "F")
map("n", "Ш", "U")
map("n", "Щ", "P")
map("n", "З", ":")
map("n", "Х", "{")
map("n", "Ъ", "}")
map("n", "Ф", "A")
map("n", "Ы", "S")
map("n", "В", "H")
map("n", "А", "T")
map("n", "П", "G")
map("n", "Р", "Y")
map("n", "О", "N")
map("n", "Л", "E")
map("n", "Д", "O")
map("n", "Ж", "I")
map("n", "Э", "'")
map("n", "Я", "Z")
map("n", "Ч", "X")
map("n", "С", "M")
map("n", "М", "C")
map("n", "И", "V")
map("n", "Т", "K")
map("n", "Ь", "L")
map("n", "Б", "<")
map("n", "Ю", ">")
