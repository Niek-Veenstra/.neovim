return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  setup = function ()
      require("bufferline").setup({
        highlight = {
          underline = true
      }
    })
  end
}
