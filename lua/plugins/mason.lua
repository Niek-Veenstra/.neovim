return {
  "mason-org/mason.nvim",
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "html",
        "cssls",
        "svelte",
        "lua_ls",
        "pyright",
        "clangd",
        "intelephense",
        "ts_ls",
        "tailwindcss",
        "volar",
      },
      automatic_installation = {
        "html",
        "cssls",
        "svelte",
        "lua_ls",
        "pyright",
        "clangd",
        "intelephense",
      },
    })
  end,
}
