local map = vim.keymap.set
map(
  "n",
  "<leader>RPY",
  ":w<CR>:TermExec cmd='python3 %'<CR>",
  { noremap = true, silent = true, desc = "Runs the current file through the python3 interpreter." }
)
map(
  "n",
  "<leader>ng",
  ":Neogit<CR>",
  { noremap = true, silent = true, desc = "Opens up NeoGit for the git repo in CWD." }
)
map(
  "n",
  "<leader>ztps",
  ":terminal powershell<CR>",
  { noremap = true, silent = true, desc = "Opens a powershell terminal." }
)
map(
  "n",
  "<leader>f",
  ":Telescope keymaps<CR>",
  { noremap = true, silent = true, desc = "Shows all the currently registered keymaps." }
)
map(
  "n",
  "<leader>fl",
  ":Telescope live_grep<CR>",
  { noremap = true, silent = true, desc = "Searches through the CWD for matches in files." }
)
map(
  "n",
  "<leader>ztsh",
  ":<C-w>l<CR>:term<CR>",
  { noremap = true, silent = true, desc = "Opens the default terminal." }
)
map(
  "n",
  "<leader>zcd",
  ":lua vim.lsp.buf.hover()<CR>",
  { noremap = true, silent = true, desc = "Shows code documentation for the code highlighted at the cursor." }
)
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
local wk = require("which-key")
local myKeymapsName = "Niek zijn keymaps"
wk.add({
  { "<leader>z", group = myKeymapsName, desc = myKeymapsName .. "." },
  { "<leader>zt", group = "Terminal launchers." },
})
