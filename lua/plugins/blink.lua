return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  version = "*",
  config = function()
    require("blink.cmp").setup({
      keymap = {
        preset = "super-tab",
        ["<C-j>"] = { "scroll_documentation_down" },
        ["<C-k>"] = { "scroll_documentation_up", "fallback" },
      },

      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
      },
      completion = {
        trigger = {
          show_on_trigger_character = true,
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    })
  end,
  opts_extend = { "sources.default" },
}
