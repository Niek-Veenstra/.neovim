-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
map(
  "n",
  "<leader>ng",
  ":Neogit<CR>",
  { noremap = true, silent = true, desc = "Opens up NeoGit for the git repo in CWD." }
)
-- Terminal stuff
map(
  "n",
  "<leader>ztps",
  ":terminal powershell<CR>",
  { noremap = true, silent = true, desc = "Opens a powershell terminal." }
)
map(
  "n",
  "<leader>ztsh",
  ":<C-w>l<CR>:term<CR>",
  { noremap = true, silent = true, desc = "Opens the default terminal." }
)
map("n", "<leader>fl", ":FzfLua grep", { silent = true, desc = "Opens the default terminal." })

map("t", "<Esc>", "<C-\\><C-n>", { silent = true, desc = "Closes the default terminal." })
-- End terminal
map(
  "n",
  "<leader>zcd",
  ":lua vim.lsp.buf.hover()<CR>",
  { noremap = true, silent = true, desc = "Shows code documentation for the code highlighted at the cursor." }
)

-- Setting filetypes
map(
  "n",
  "<leader>sfp",
  ":set ft=php<CR>",
  { noremap = true, silent = true, desc = "Sets the current buffer filetype to php." }
)
map(
  "n",
  "<leader>sfh",
  ":set ft=html<CR>",
  { noremap = true, silent = true, desc = "Sets the current buffer filetype to html." }
)
-- End filetypes

local wk = require("which-key")
local myKeymapsName = "Niek zijn keymaps"
wk.add({
  { "<leader>z", group = myKeymapsName, desc = myKeymapsName .. "." },
  { "<leader>zt", group = "Terminal launchers." },
})
