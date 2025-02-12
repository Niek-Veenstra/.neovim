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
  callback = function()
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

vim.api.nvim_create_augroup("haskell_keybindings", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  pattern = "*.hs",
  group = "haskell_keybindings",
  callback = function()
    local ht = require("haskell-tools")
    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "<leader>hs", ht.hoogle.hoogle_signature, opts)

    vim.api.nvim_create_autocmd({ "BufLeave" }, {
      pattern = "*.hs",
      group = "haskell_keybindings",
      callback = function()
        xpcall(function()
          vim.keymap.del("n", "<leader>hs")
        end, function() end)
        return true
      end,
    })
  end,
})
