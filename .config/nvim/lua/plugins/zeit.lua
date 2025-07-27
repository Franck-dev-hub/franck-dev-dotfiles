-- Integration of the 'zeit' CLI time tracker with Neovim
-- See: https://github.com/mrusme/zeit
-- This plugin file provides Neovim commands to interact with zeit directly from the editor.

-- Helper function to run zeit commands and show output in a floating window
local function run_zeit(args)
  local output = vim.fn.systemlist('zeit ' .. args)
  -- Create a new scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
  -- Open a floating window
  local width = math.floor(vim.o.columns * 0.7)
  local height = math.floor(vim.o.lines * 0.5)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })
end

-- Command: ZeitList - show all tracked activities
vim.api.nvim_create_user_command('ZeitList', function()
  run_zeit('list --total')
end, {})

-- Command: ZeitTracking - show current activity
vim.api.nvim_create_user_command('ZeitTracking', function()
  run_zeit('tracking')
end, {})

-- Command: ZeitStart - start tracking a new activity (prompts for project and task)
vim.api.nvim_create_user_command('ZeitStart', function()
  local project = vim.fn.input('Project: ')
  local task = vim.fn.input('Task: ')
  if project ~= '' and task ~= '' then
    run_zeit('track --project "' .. project .. '" --task "' .. task .. '"')
  else
    print('Project and Task are required!')
  end
end, {})

-- Command: ZeitFinish - finish current activity
vim.api.nvim_create_user_command('ZeitFinish', function()
  run_zeit('finish')
end, {})

-- Now you can use :ZeitList, :ZeitTracking, :ZeitStart, :ZeitFinish in Neovim 