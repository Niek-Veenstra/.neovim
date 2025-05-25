local functions = require("config.functions")
local bufferline = require("bufferline")
return {
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    vim.opt.termguicolors = true
    bufferline.setup({
      options = {
        separator_style = "slant",
        sort_by = functions.sort_terminal,
      },
      highlights = {
        buffer_selected = {
          underline = true,
          bold = true,
          sp = "#800080",
        },
      },
    })
  end,
}
