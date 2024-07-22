-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local vimapi = vim.api
map("n", "<leader>RPY", ":w<CR>:TermExec cmd='python3 %'<CR>", { noremap = true, silent = true })
map("n", "<leader>fl", ":Telescope live_grep<CR>", { noremap = true, silent = true })
map("n", "<leader>ng", ":Neogit<CR>", { noremap = true, silent = true })
map("n", "<leader>ps", ":terminal powershell<CR>", { noremap = true, silent = true })
local fontsize = 12
function AdjustFontSize(amount)
  fontsize = fontsize + amount
  vimapi.nvim_command(":GuiFont! Consoas:h " .. fontsize)
end
map("n", "<C-ScrollWheelUp>", ":call AdjustFontSize(1)<CR>", { noremap = true, silent = true })
map("n", "<C-ScrollWheelDown>", ":call AdjustFontSize(-1)<CR>", { noremap = true, silent = true })
map("i", "<C-ScrollWheelUp>", "<Esc>:call AdjustFontSize(1)<CR>", { noremap = true, silent = true })
map("i", "<C-ScrollWheelDown>", "<Esc>:call AdjustFontSize(-1)<CR>", { noremap = true, silent = true })
