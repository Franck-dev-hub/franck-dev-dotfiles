-- Auto-command for html, css
vim.api.nvim_create_autocmd("FileType", {
  pattern = "html, css",
  callback = function()
    -- Indentation
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    end
})

