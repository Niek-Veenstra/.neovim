return {
  "nvim-telescope/telescope-media-files.nvim",
  dependencies = { "nvim-telescope/telescope-media-files.nvim" },
  config = function()
    local ts = require("telescope")
    ts.setup({
      extensions = {
        media_files = {
          find_cmd = "rg",
          filetypes = { "png", "webp", "jpg", "jpeg" },
        },
      },
    })
    ts.load_extension("media_files")
  end,
}
