local M = {}

function M.is_diagnostic()
	-- Get the current cursor position (line and column)
	local cursor_position = vim.api.nvim_win_get_cursor(0)
	local line = cursor_position[1] - 1 -- Convert to 0-based index
	local col = cursor_position[2]

	-- Get diagnostics at the cursor position
	local diagnostics = vim.diagnostic.get(0, { lnum = line, col = col })

	-- Check if there are any diagnostics
	return #diagnostics > 0
end

function  M.adjust_font_size(amount)
  local current_size = vim.o.guifont:match("%d+")
  local new_size = current_size + amount
  vim.o.guifont = vim.o.guifont:gsub("%d+", new_size)
end

return M
