-- Auto-command for JavaScript
vim.api.nvim_create_autocmd("FileType", {
  pattern = "javascript",
  callback = function()
    -- Indentation
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2

    -- Activate linting with ESLint if installed
    vim.cmd([[setlocal formatprg=eslint\ --fix\ --stdin\ --stdin-filename\ %]])

    vim.api.nvim_create_autocmd("BufWritePre", {
	    pattern = "*.js",
	    command = "EslintFixAll"
    })
    end
})
