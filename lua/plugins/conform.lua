local homePath = os.getenv("HOME")
return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufLeave" },
  opts = {
    formatters_by_ft = {
      html = { "prettier" },
      vue = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      javascript = { "prettier" },
      go = { "gofumpt", "goimports_reviser", "goline" },
      c = { "clangf" },
      cpp = { "clangf" },
      h = { "clangf" },
      rust = { "rustfmt", lsp_format = "fallback" },
    },
    format_after_save = {
      lsp_format = "fallback",
    },
    notify_on_error = true,
    formatters = {
      php = {
        command = "php-cs-fixer",
        args = {
          "fix",
          "--config=" .. homePath .. "/.config/nvim/php-cs-fixer.php",
          "$FILENAME",
        },
        stdin = false,
      },
      clangf = {
        command = "clang-format",
        args = {
          "-i",
          "--style=file",
          "--assume-filename=" .. homePath .. "/.config/nvim/.clang-format",
          "$FILENAME",
        },
        stdin = false,
      },
    },
  },
}
