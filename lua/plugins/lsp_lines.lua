return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  enabled = true,
  dependencies = {
    "git@github.com:neovim/nvim-lspconfig.git",
  },
  config = function()
    vim.diagnostic.config({
      virtual_text = false,
    })
  end,
}
