vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local keymap = vim.keymap.set
local silent = { silent = true }

-- Navigate vim panes better
keymap("n", "<c-k>", ":wincmd k<CR>")
keymap("n", "<c-j>", ":wincmd j<CR>")
keymap("n", "<c-h>", ":wincmd h<CR>")
keymap("n", "<c-l>", ":wincmd l<CR>")
keymap("n", "<leader>w", ":write<CR>")
keymap("n", "<leader>x", ":bdelete<CR>")
keymap("n", "<c-w>", ":bdelete<CR>")

-- Create a vertical split
keymap("n", "<leader>sv", ":vs<CR>")

keymap("n", "<ESC>", ":nohlsearch<CR>")
vim.wo.number = true
vim.wo.relativenumber = true

-- Keep visual mode indenting
keymap("v", "<", "<gv", silent)
keymap("v", ">", ">gv", silent)

-- Quick line navigation
keymap("n", "gh", "^", silent)
keymap("n", "gl", "$", silent)
keymap("v", "gh", "^", silent)
keymap("v", "gl", "$", silent)
-- keymap("o", "gh", "^", silent)
-- keymap("o", "gl", "$", silent)

-- Don't yank on delete char
keymap("n", "x", '"_x', silent)
keymap("n", "X", '"_X', silent)
keymap("v", "x", '"_x', silent)
keymap("v", "X", '"_X', silent)

-- Don't yank on visual paste
keymap("v", "p", '"_dP', silent)

-- Helper function to determine the current window's position
local function resize_split(direction)
	if direction == "left" then
		vim.cmd("vertical resize +5") -- Always increase the current split width
	elseif direction == "right" then
		vim.cmd("vertical resize -5") -- Always decrease the current split width
	elseif direction == "up" then
		vim.cmd("resize +5") -- Always increase the current split height
	elseif direction == "down" then
		vim.cmd("resize -5") -- Always decrease the current split height
	end
end

-- Keybindings for dynamic resizing
keymap("n", "<A-h>", function()
	resize_split("left")
end, { noremap = true, silent = true })
keymap("n", "<A-l>", function()
	resize_split("right")
end, { noremap = true, silent = true })
keymap("n", "<A-k>", function()
	resize_split("up")
end, { noremap = true, silent = true })
keymap("n", "<A-j>", function()
	resize_split("down")
end, { noremap = true, silent = true })

keymap("n", "q", "<cmd>q<CR>")

keymap("n", "H", "<cmd>BufferLineCyclePrev<CR>")
keymap("n", "L", "<cmd>BufferLineCycleNext<CR>")

keymap("n", "<leader>e", function()
	require("yazi").yazi()
end)

keymap("n", "<leader>fb", function()
	require("conform").format({ async = true, lsp_fallback = true })
end)

keymap({ "n", "v", "i" }, "<C-\\>", function()
	require("agentic").toggle()
end, { desc = "Toggle Agentic Chat" })

keymap({ "n", "v" }, "<C-`>", function()
	require("agentic").add_selection_or_file_to_context()
end, { desc = "Add file or selection to Agentic to Context" })

keymap({ "n", "v" }, "<C-,>", function()
	require("agentic").new_session()
end, { desc = "New Agentic Session" })

