-- Auto-command for Rust
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    -- Indentation
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
    -- Autoformat with rustfmt at the save
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.rs",
      callback = function()
        -- Execute rustfmt on the current file
        vim.cmd("silent! !rustfmt %")
        -- Reload buffer after format
        vim.cmd("edit!")
      end,
    })
  end
})

