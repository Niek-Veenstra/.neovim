local homePath = os.getenv("HOME")
return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufLeave" },
  opts = {
    formatters_by_ft = {
      php = { "php" },
      js = { "prettier" },
      html = { "prettier" },
      go = { "gofumpt", "goimports_reviser", "goline" },
      cpp = { "clangf" },
      h = { "clangf" },
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
