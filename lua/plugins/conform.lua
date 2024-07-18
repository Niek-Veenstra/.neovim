return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      php = { "php" },
    },
    format_on_save = {
      lsp_fallback = true,
      async = false,
      timeout_ms = 500,
    },
    notify_on_error = true,
    formatters = {
      php = {
        command = "php-cs-fixer",
        args = {
          "fix",
          "$FILENAME",
          "--config=config_filepath.php",
        },
        stdin = false,
      },
    },
  },
}
