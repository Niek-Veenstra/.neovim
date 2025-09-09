local map = vim.keymap.set
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
map("n", "<M-Right>", ":BufferLineMoveNext<CR>", { silent = true, desc = "Move buffer right." })
map("n", "<M-Left>", ":BufferLineMovePrev<CR>", { silent = true, desc = "Move buffer left." })
-- End bufferline

-- Git.
map(
  "n",
  "<leader>ng",
  ":Neogit<CR>",
  { noremap = true, silent = true, desc = "Opens up NeoGit for the git repo in CWD." }
)
map(
  "n",
  "<leader>gf",
  require("fzf-lua").git_bcommits,
  { noremap = true, silent = true, desc = "Show git file history." }
)
-- End git.

-- Finder

-- If this does not work, might be due to the fact some terminal difference shift difference.
-- Information: https://neovim.io/doc/user/intro.html#CTRL-%7Bchar%7D
map(
  { "n", "i" },
  "<S-Left><S-Left>",
  ":Telescope find_files<CR>",
  { noremap = true, silent = true, desc = "Opens file finder." }
)

-- End Finder

-- Code
map(
  "n",
  "zcd",
  vim.lsp.buf.hover,
  { noremap = true, silent = true, desc = "Shows code documentation for the code highlighted at the cursor." }
)
-- End code

local wk = require("which-key")
local myKeymapsName = "Niek zijn keymaps"
wk.add({
  { "z", group = myKeymapsName, desc = myKeymapsName .. "." },
  { "zt", group = "Terminal launchers." },
})
