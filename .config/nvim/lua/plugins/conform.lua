return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			typesctipt = { "biome" },
			javascript = { "biome" },
			python = { "black" },
		},
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		-- Format file
	},
	vim.keymap.set("n", "<leader>fb", function()
		require("conform").format({ async = true })
		print("File formatted")
	end, { desc = "Format code with conform.nvim" }),
}
