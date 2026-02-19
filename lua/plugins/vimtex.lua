return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
      continuous = 1,
      callbacks = 1,
      engine = "pdf",
      executable = "latexmk",
      options = {
        "-shell-escape",
        "-interaction=nonstopmode",
        "-file-line-error",
        "-synctex=1",
      },
    }

    vim.keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<cr>")
    vim.keymap.set("n", "<leader>lk", "<cmd>VimtexStop<cr>")
    vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<cr>")
    vim.keymap.set("n", "<leader>lt", "<cmd>VimtexTocOpen<cr>")
    vim.keymap.set("n", "<leader>lc", "<cmd>VimtexClean<cr>")
    vim.keymap.set("n", "<leader>le", "<cmd>VimtexErrors<cr>")
    vim.keymap.set("n", "<leader>lj", "<cmd>VimtexView<cr>")
  end,
}
