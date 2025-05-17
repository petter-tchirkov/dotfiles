return {
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { silent = true, desc = "Lazygit" }),
}
