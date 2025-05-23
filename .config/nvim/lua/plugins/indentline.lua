return {
	"echasnovski/mini.indentscope",
	version = false,
	config = function()
		require("mini.indentscope").setup({
			options = {
				indent_cursor = false,
				try_as_border = true,
			},
			draw = {
				delay = 100,
				animation = function()
					return 0
				end,
			},
		})
	end,
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"Trouble",
				"trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
			},
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})
	end,
}
