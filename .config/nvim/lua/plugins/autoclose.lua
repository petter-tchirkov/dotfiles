return {
	{
		"m4xshen/autoclose.nvim",
		opts = {
			options = {
				disabled_filetypes = { "text", "markdown" },
				disable_when_touch = true,
				pair_spaces = true,
			},
			keys = {
				["'"] = {
					escape = true,
					close = true,
					pair = "''",
					disabled_filetypes = { "markdown" },
				},
				["`"] = { escape = false, close = true, pair = "``" },
				[">"] = { escape = false, close = false, pair = "><" },
			},
		},
	},
	{ "windwp/nvim-ts-autotag", opts = {} },

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},

	vim.keymap.set("n", "gs", "<Plug>(nvim-surround-normal)", {
		desc = "Add a surrounding pair around a motion (normal mode)",
	}),
}
