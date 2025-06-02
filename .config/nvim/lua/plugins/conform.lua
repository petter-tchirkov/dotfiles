return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			-- javascript = { "prettier" },
			-- typescript = { "prettier" },
			-- vue = { "prettier" },
		},
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		-- Format file
	},
	vim.keymap.set("n", "<leader>fc", function()
		require("conform").format({ async = true })
		print("File formatted")
	end, { desc = "Format code with conform.nvim" }),
}
