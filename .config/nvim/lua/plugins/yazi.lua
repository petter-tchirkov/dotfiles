return {
	-- @type LazySpec
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		dependencies = {
			-- check the installation instructions at
			-- https://github.com/folke/snacks.nvim
			"folke/snacks.nvim",
		},
		keys = {
			{
				"<leader>e",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		---@type YaziConfig | {}
		opts = {
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
			},
		},

		highlight_groups = {
			-- See https://github.com/mikavilpas/yazi.nvim/pull/180
			hovered_buffer = nil,
			-- See https://github.com/mikavilpas/yazi.nvim/pull/351
			hovered_buffer_in_same_directory = nil,
		},
		floating_window_scaling_factor = 0.7,
		init = function()
			vim.g.loaded_netrwPlugin = 1
		end,
	},
	-- {
	-- 	'dangooddd/kanagawa',
	-- 	lazy = true,
	-- 	build = function(plugin)
	-- 	      require("yazi.plugin").build_flavor(plugin)
	-- 	end,
	-- }
}
