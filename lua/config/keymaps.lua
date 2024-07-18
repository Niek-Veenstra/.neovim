-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local vimapi = vim.api
map("n", "<leader>RPY", ":w<CR>:TermExec cmd='python3 %'<CR>", { noremap = true, silent = true })
map("n", "<leader>fl", ":Telescope live_grep<CR>", { noremap = true, silent = true })
map("n", "<leader>ng", ":Neogit<CR>", { noremap = true, silent = true })
map("n", "<leader>ps", ":terminal powershell<CR>", { noremap = true, silent = true })
map("n", "<C-a>", function()
  local current_line = vim.api.nvim_win_get_cursor(0)[0]
  vim.api.nvim_feedkeys(vimapi.nvim_replace_termcodes("gg0VG", true, false, true), "n", false)
  vim.api.nvim_feedkeys(vimapi.nvim_replace_termcodes(current_line .. "G", true, false, true), "n", false)
end, { noremap = true, silent = true })

map("i", "<C-a>", function()
  local current_line = vim.api.nvim_win_get_cursor(0)[0]
  vim.api.nvim_feedkeys(vimapi.nvim_replace_termcodes("<Esc>gg0VG", true, false, true), "n", false)
  vim.api.nvim_feedkeys(vimapi.nvim_replace_termcodes(current_line .. "G", true, false, true), "n", false)
end, { noremap = true, silent = true })
