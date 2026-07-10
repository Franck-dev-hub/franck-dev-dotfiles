-- New nvim-treesitter API (rewrite, requires Neovim 0.12+)
-- ensure_installed is now done via install(), highlight via vim.treesitter.start()
require('nvim-treesitter').install({
  "bash", "c", "css", "cpp", "go", "html", "java", "javascript",
  "json", "lua", "markdown", "markdown_inline", "python", "rust",
  "tsx", "typescript"
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    "bash", "c", "css", "cpp", "go", "html", "java", "javascript",
    "json", "lua", "markdown", "python", "rust", "tsx", "typescript"
  },
  callback = function() vim.treesitter.start() end,
})
