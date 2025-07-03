return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  version = "*",
  opts = {
    keymap = {
      preset = "super-tab",
      ["<C-j>"] = { "scroll_documentation_down" },
      ["<C-k>"] = { "scroll_documentation_up", "fallback" },
      ["<Tab>"] = {
        require("blink.cmp.keymap.presets").get("super-tab")["<Tab>"][1],
        require("lazyvim.util.cmp").map({ "snippet_forward", "ai_accept" }),
        "fallback",
      },
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
  },
  opts_extend = { "sources.default" },
}
