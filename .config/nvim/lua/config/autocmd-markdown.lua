-- Auto-command for markdown
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Spell corrector & auto backspace
    vim.wo.spell = true
    vim.wo.wrap = true

    -- Indentation
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2

    -- Max row width
    vim.wo.textwidth = 80
    vim.wo.linebreak = true
  end
})
