local map = vim.keymap.set
map(
  "n",
  "<leader>ng",
  ":Neogit<CR>",
  { noremap = true, silent = true, desc = "Opens up NeoGit for the git repo in CWD." }
)
-- Terminal
map("n", "ztps", ":terminal powershell<CR>", { noremap = true, silent = true, desc = "Opens a powershell terminal." })
map("n", "ztsh", ":<C-w>l<CR>:term<CR>", { noremap = true, silent = true, desc = "Opens the default terminal." })
map("n", "<leader>fl", LazyVim.pick("live_grep"), { silent = true, desc = "RipGrep file content search." })

map("t", "<Esc>", "<C-\\><C-n>", { silent = true, desc = "Closes the default terminal." })
map("n", "cr", ":IncRename ", { noremap = true, silent = true, desc = "Inc rename" })
-- End terminal

-- Bufferline
map("n", "<leader>bs", function()
  functions = require("config.functions")
  require("bufferline").sort_by(functions.sort_terminal)
end, { noremap = true, silent = true, desc = "Sort" })

map("n", "<M-Right>", ":BufferLineMoveNext<CR>", { noremap = true, silent = true, desc = "Sort" })
map("n", "<M-Left>", ":BufferLineMovePrev<CR>", { noremap = true, silent = true, desc = "Sort" })

-- End bufferline
map(
  "n",
  "zcd",
  vim.lsp.buf.hover,
  { noremap = true, silent = true, desc = "Shows code documentation for the code highlighted at the cursor." }
)

local wk = require("which-key")
local myKeymapsName = "Niek zijn keymaps"
wk.add({
  { "z", group = myKeymapsName, desc = myKeymapsName .. "." },
  { "zt", group = "Terminal launchers." },
})
