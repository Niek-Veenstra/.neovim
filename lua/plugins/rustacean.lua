return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  lazy = false,
  config = function()
    vim.g.rustaceanvim = {
      tools = {},
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
            check = {
              allTargets = false,
            },
            diagnostics = { enable = true },
          },
        },
      },
    }
  end,
}
