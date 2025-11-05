-- Auto-command for Python
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    -- Indentation
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
    end
})

