return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufLeave" },
  config = {
    formatters_by_ft = {
      php = { "php" },
      js = { "prettier" },
      html = { "prettier" },
    },
    notify_on_error = true,
    formatters = {
      php = {
        command = "php-cs-fixer",
        args = {
          "fix",
          "--config=" .. os.getenv("HOME") .. "/.config/nvim/php-cs-fixer.php",
          "$FILENAME",
        },
        stdin = false,
      },
    },
  },
}
