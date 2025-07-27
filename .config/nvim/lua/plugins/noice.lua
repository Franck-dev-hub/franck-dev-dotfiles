-- Noice.nvim configuration for command line popup appearance and position
-- See: https://github.com/folke/noice.nvim#-configuration

require("noice").setup({
  cmdline = {
    enabled = true, -- Enable the enhanced command line UI
    view = "cmdline_popup", -- Use the popup view for the command line
  },
  views = {
    cmdline_popup = {
      -- Position of the popup
      position = {
        row = "20%", -- position at the bottom of the screen
        col = "50%", -- position at the center of the screen
      },
      -- Set the popup size
      size = {
        width = 60, -- width in columns
        height = 1, -- height in rows
      },
      -- Style the popup border
      border = {
        style = "rounded", -- border style: 'single', 'rounded', etc.
        padding = { 1, 2}, -- padding: {vertical, horizontal}
      },
      -- Window highlight groups for custom colors
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      },
    },
  },
}) 