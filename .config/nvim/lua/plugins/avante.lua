return {
	"yetone/avante.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
				latext = { enabled = false },
			},
			ft = { "markdown", "Avante" },
		},
	},
	build = "make",
	opts = {
		provider = "gemini",
		gemini = {
			-- @see https://ai.google.dev/gemini-api/docs/models/gemini
			model = "gemini-2.5-pro-exp-03-25",
			temperature = 0,
			max_tokens = 4096,
		},
	},
}
