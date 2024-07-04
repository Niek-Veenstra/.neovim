-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
map("n", "<leader>RPY", ":w<CR>:TermExec cmd='python3 %'<CR>", { noremap = true, silent = true })
map("n", "<leader>fl", ":Telescope live_grep<CR>", { noremap = true, silent = true })
map("n", "<leader>ng", ":Neogit<CR>", { noremap = true, silent = true })
