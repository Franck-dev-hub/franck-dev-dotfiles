-- Auto-command for JavaScript
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"javascript", "javascriptreact"},
  callback = function()
    -- Indentation
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    -- Autoformat with eslint at the save
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = {"*.js", "*.jsx"},
      callback = function()
        -- Execute npm run fix on the current file
        vim.cmd("silent! !npx run --fix")
        -- Reload buffer after format
        vim.cmd("edit!")
      end
    })
    end
})
