return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = { "html", "css", "lua", "typescript", "tsx", "vue", "json" },
			highlight = {
				enable = true,
			},
		})
	end,
}
