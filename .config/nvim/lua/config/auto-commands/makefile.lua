-- Auto-command for Makefiles
vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  callback = function()
    -- Indentation
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 8
    vim.bo.tabstop = 8
    end
})

