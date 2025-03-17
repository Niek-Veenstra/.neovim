return {
  "smjonas/inc-rename.nvim",
  enabled = true,
  config = function()
    require("inc_rename").setup({})
    vim.keymap.set("n", "<leader>cr", ":IncRename ", { noremap = true })
    require("noice").setup({
      presets = { inc_rename = true },
    })
  end,
}
