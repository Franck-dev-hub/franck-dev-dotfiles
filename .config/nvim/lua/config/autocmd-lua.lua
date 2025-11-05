-- Auto-command for lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    -- Indentation
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    end
})

