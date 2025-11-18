-- Auto-command for Assembly
vim.api.nvim_create_autocmd("FileType", {
  pattern = "assembly",
  callback = function()
    -- Indentation
    vim.bo.expandtab = false
    vim.bo.shiftwidth = 8
    vim.bo.tabstop = 8
    end
})

