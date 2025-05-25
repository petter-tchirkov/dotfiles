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
			model = "gemini-2.5-flash-preview-04-17",
			temperature = 0,
			max_tokens = 4096,
		},
	},
}
