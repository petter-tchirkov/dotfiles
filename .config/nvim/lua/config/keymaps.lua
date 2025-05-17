local keymap = vim.keymap.set
local silent = { silent = true }

-- Navigate vim panes better
keymap("n", "<c-k>", ":wincmd k<CR>")
keymap("n", "<c-j>", ":wincmd j<CR>")
keymap("n", "<c-h>", ":wincmd h<CR>")
keymap("n", "<c-l>", ":wincmd l<CR>")
keymap("n", "<leader>w", ":write<CR>")
keymap("n", "<leader>x", ":bd<CR>")

-- Create a vertical split
keymap("n", "<leader>sv", ":vs<CR>")

keymap("n", "<ESC>", ":nohlsearch<CR>")
vim.wo.number = true
vim.wo.relativenumber = true

-- Keep visual mode indenting
keymap("v", "<", "<gv", silent)
keymap("v", ">", ">gv", silent)

-- Don't yank on delete char
keymap("n", "x", '"_x', silent)
keymap("n", "X", '"_X', silent)
keymap("v", "x", '"_x', silent)
keymap("v", "X", '"_X', silent)

-- Don't yank on visual paste
keymap("v", "p", '"_dP', silent)

-- Helper function to determine the current window's position
local function resize_split(direction)
	local win_id = vim.api.nvim_get_current_win()
	local win_width = vim.api.nvim_win_get_width(win_id)
	local win_height = vim.api.nvim_win_get_height(win_id)

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
vim.keymap.set("n", "<A-h>", function()
	resize_split("left")
end, { noremap = true, silent = true })
vim.keymap.set("n", "<A-l>", function()
	resize_split("right")
end, { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", function()
	resize_split("up")
end, { noremap = true, silent = true })
vim.keymap.set("n", "<A-j>", function()
	resize_split("down")
end, { noremap = true, silent = true })

vim.keymap.set("n", "q", "<cmd>q<CR>")
