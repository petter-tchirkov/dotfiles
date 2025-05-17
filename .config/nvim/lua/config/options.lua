-- Use spaces instead of tabs
vim.opt.expandtab = true

-- Number of spaces to use for auto-indent (<<, >> commands)
vim.opt.shiftwidth = 4

-- Number of visual spaces per TAB character
vim.opt.tabstop = 2

-- Number of spaces inserted when pressing TAB
-- When 'expandtab' is off, this uses a mix of tabs and spaces.
-- When 'expandtab' is on, this dictates the number of spaces for TAB.
vim.opt.softtabstop = 2

-- Enable smart tabbing, respects 'shiftwidth' for indentation at the start of a line
vim.opt.smarttab = true

-- Enable smart auto-indenting for C-like programs
vim.opt.smartindent = true

-- Copy indent from the previous line when starting a new line
vim.opt.autoindent = true

-- Indent wrapped lines visually to match the starting indentation
vim.opt.breakindent = true

-- Show line numbers
vim.opt.number = true

-- Show relative line numbers (distance from the cursor) alongside the absolute number for the current line
vim.opt.relativenumber = true

-- Highlight the current line the cursor is on
vim.opt.cursorline = true

-- Enable persistent undo history stored in files
vim.opt.undofile = true

-- Enable mouse support in all modes (normal, visual, insert, command)
vim.opt.mouse = "a"

-- Hide the mode indicator (e.g., -- INSERT --), assuming it's shown in a status line
vim.opt.showmode = false

-- Make searching case-insensitive
vim.opt.ignorecase = true

-- Override 'ignorecase' if the search pattern contains uppercase letters
vim.opt.smartcase = true

-- Always show the sign column (used for diagnostics, git signs, etc.), prevents layout shifts
vim.opt.signcolumn = "yes"

-- Open new vertical splits to the right of the current window
vim.opt.splitright = true

-- Open new horizontal splits below the current window
vim.opt.splitbelow = true

-- Show invisible characters
vim.opt.list = true

-- Define how invisible characters are displayed
-- 'tab': Character for tab
-- 'trail': Character for trailing whitespace
-- 'nbsp': Character for non-breaking space
vim.opt.listchars = { tab = ". ", trail = "·", nbsp = "␣" }

-- Keep at least 5 screen lines visible above and below the cursor when scrolling
vim.opt.scrolloff = 5

-- Number of command history entries to keep
vim.opt.history = 1000

-- Time in milliseconds to wait for mapped sequence completion (affects which-key)
vim.opt.timeoutlen = 500

-- Time in milliseconds Vim waits for inactivity before triggering CursorHold events (used by plugins)
vim.opt.updatetime = 300

-- Highlight search matches incrementally as you type
vim.opt.incsearch = true

-- Disable the creation of swap files (requires 'undofile' for recovery)
vim.opt.swapfile = false

-- Defer drawing updates during macros, complex operations, etc., for performance
vim.opt.lazyredraw = true

-- Set clipboard integration: Use system clipboard ("unnamedplus") unless in an SSH session
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

-- Hide the command line height when not in use (set to 0)
vim.opt.cmdheight = 0

-- Enable 24-bit RGB color support in the terminal
vim.opt.termguicolors = true

-- Set the maximum line width; used by formatting commands like 'gq'
vim.opt.textwidth = 80

-- Display a visual marker at the 'textwidth' column (Uncomment if desired)
-- vim.opt.colorcolumn = "80"

-- Disable automatic line wrapping
vim.opt.wrap = false

-- Allow switching between buffers without saving the current one
vim.opt.hidden = true

-- Highlight matching brackets when the cursor is on one
vim.opt.showmatch = true

-- Enable enhanced command-line completion menu
vim.opt.wildmenu = true

-- Set command-line completion mode: complete longest common string, then list all matches, then cycle through full matches
vim.opt.wildmode = "longest:full,full"

-- Prevent automatic resizing of windows to be equal when splits are created or closed
vim.opt.equalalways = false

-- Control when the status line is displayed: 3 = always display (global statusline)
vim.opt.laststatus = 3

local function augroup(name)
	return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("VimEnter", {
	group = augroup("autoupdate"),
	callback = function()
		require("lazy").update({
			show = false,
		})
	end,
})
