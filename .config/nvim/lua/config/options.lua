local options = {
	laststatus = 3,
	ruler = false,		-- Disable extra numbering
	showmode = false,	-- Not needed due to lualine
	showcmd = false,
	wrap = true,		-- Toggle bound to leader W
	mouse = "",		-- Enable mouse
	clipboard = "unnamedplus", -- System clipboard integration
	history = 100,		-- Command line history
	swapfile = false,	-- Swap just gets in the way, usually
	backup = false,
	undofile = true,	-- Undos are saved to file
	cursorline = true,	-- Highlight line
	ttyfast = true,		-- Faster scrolling
	smoothscroll = true,
	title = true,		-- Automatic window titlebar
	
	number = true,		-- Numbering lines
	relativenumber = false, -- Disable relative line numbers
	numberwidth = 4,

	smarttab = true,	-- Indentation stuff
	cindent = true,
	autoindent = false,
	tabstop = 8,		-- Visual width of a tab
	softtabstop = 8,	-- Editing width of a tab
	shiftwidth = 8,		-- Auto-indent width
	expandtab = false,	-- Use spaces

	foldmethod = "expr",
	foldlevel = 99,		-- Disable folding, lower #s enable
	foldexpr = "nvim_treesitter#foldexpr()",
	
	termguicolors = true,

	ignorecase = true,	-- Ignore case while searching
	smartcase = true,	-- But do not ignore if caps are used

	conceallevel = 2,	-- Markdown conceal
	concealcursor = "nc",

	splitkeep = 'screen',	-- Stablizie window open/close
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.diagnostic.config({
	signs = false,
})
