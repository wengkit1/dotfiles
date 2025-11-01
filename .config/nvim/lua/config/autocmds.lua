-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`

-- Set filetype for Jupyter notebooks
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.ipynb",
  callback = function()
    vim.bo.filetype = "quarto"
  end,
})

-- Force quarto filetype for test file
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*test_quarto.md",
  callback = function()
    vim.bo.filetype = "quarto"
  end,
})
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
