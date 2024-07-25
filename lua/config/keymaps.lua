local map = vim.keymap.set
local vimapi = vim.api
-- Python
map("n", "<leader>RPY", ":w<CR>:TermExec cmd='python3 %'<CR>", { noremap = true, silent = true })
-- Telescope
map("n", "<leader>fl", ":Telescope live_grep<CR>", { noremap = true, silent = true })

-- Git
map("n", "<leader>ng", ":Neogit<CR>", { noremap = true, silent = true })

-- Terminal
map("n", "<leader>ps", ":terminal powershell<CR>", { noremap = true, silent = true })

local fontsize = 12
function AdjustFontSize(amount)
  fontsize = fontsize + amount
  vimapi.nvim_command(":GuiFont! Consoas:h " .. fontsize)
end
map("n", "<C-ScrollWheelUp>", ":lua AdjustFontSize(1)<CR>", { noremap = true, silent = true })
map("n", "<C-ScrollWheelDown>", ":lua AdjustFontSize(-1)<CR>", { noremap = true, silent = true })
map("i", "<C-ScrollWheelUp>", "<Esc>:lua AdjustFontSize(1)<CR>", { noremap = true, silent = true })
map("i", "<C-ScrollWheelDown>", "<Esc>:lua AdjustFontSize(-1)<CR>", { noremap = true, silent = true })
map("n", "<leader>zsh", ":<C-w>l<CR>:term<CR>", { noremap = true, silent = true })

-- Set filetype for html and php workaround.
map("n", "<leader>sfp", ":set ft=php<CR>", { noremap = true, silent = true })
map("n", "<leader>sfh", ":set ft=html<CR>", { noremap = true, silent = true })

-- Set filetype for html and php workaround.

-- Set filetype for html and php workaround.
