-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_augroup("go_keybindings", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  pattern = "*.go",
  group = "go_keybindings",
  callback = function(ev)
    vim.keymap.set(
      "n",
      "<leader>zdn",
      ":lua require('dap-go').debug_test()<CR>",
      { silent = true, noremap = true, desc = "Debugs the nearest test to the users cursor." }
    )
    vim.api.nvim_create_autocmd({ "BufLeave" }, {
      pattern = "*.go",
      group = "go_keybindings",
      callback = function()
        xpcall(function()
          vim.keymap.del("n", "<leader>zdn")
        end, function() end)
        return true
      end,
    })
  end,
})
