return {
	{
		"echasnovski/mini-git",
		version = false,
		main = "mini.git",
		opts = {},
	},
	{
		"echasnovski/mini.diff",
		version = false,
		opts = {},
	},
	{
		"echasnovski/mini.statusline",
		dependencies = { "echasnovski/mini.icons", "echasnovski/mini.diff", "echasnovski/mini-git" },
		version = false,
		config = function()
			local MiniStatusline = require("mini.statusline")
			local icons = require("config.icons")
			MiniStatusline.setup({
				content = {
					-- Define the active statusline
					use_icons = true,
					active = function()
						local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
						local filename = MiniStatusline.section_filename({ trunc_width = 1200 })
						local searchcount = MiniStatusline.section_searchcount({ trunc_width = 120 })
						local git = MiniStatusline.section_git({ trunc_width = 120 })
						local git_diff = MiniStatusline.section_diff({ trunc_width = 120 })
						local get_lsp_clients = function()
							local clients = vim.lsp.get_clients({ buffer = bufnr })
							local client_names = {}

							for _, client in ipairs(clients) do
								table.insert(client_names, client.name)
							end
							if #client_names > 0 then
								return "LSP"
							end
						end
						local get_diagnostics = function()
							local res = {}
							local diagnostic_levels = { "ERROR", "WARN", "INFO", "HINT" }

							for _, level in ipairs(diagnostic_levels) do
								local n = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity[level] }) or 0
								if n > 0 then
									local icon = icons.diagnostics[level] -- Use your icons for diagnostics
									local hl_group = "Diagnostic" .. level -- Use Neovim's built-in highlight groups
									table.insert(res, string.format("%%#%s#%s %d%%*", hl_group, icon, n))
								end
							end

							return table.concat(res, " ")
						end

						local get_mmodified_status = function()
							if vim.bo.modified then
								return "MiniFilesBorderModified"
							end
							return "diffAdded"
						end

						return MiniStatusline.combine_groups({
							-- Left group: Vim mode
							{
								hl = mode_hl,
								strings = { mode },
							},
							{
								hl = "LspSignatureActiveParameter",
								strings = { get_lsp_clients() },
							},
							{
								hl = "NeogitHunkHeader", -- Separate highlight for the rest of the left group
								strings = { git },
							},
							{
								hl = "MiniStatuslineLeft", -- Separate highlight for the rest of the left group
								strings = { get_diagnostics() },
							},
							{
								hl = "MiniStatuslineLeft", -- Separate highlight for the rest of the left group
								strings = { searchcount },
							},
							{
								hl = get_mmodified_status(),
								strings = { filename },
							},
							"%=",
							-- Right group: Git diff, LSP info, filetype icon
							{
								hl = "MiniStatuslineLeft", -- Separate highlight for the rest of the left group
								strings = { git_diff },
							},
						})
					end,
					-- Define the inactive statusline
					inactive = function()
						return MiniStatusline.combine_groups({
							{
								hl = "MiniStatuslineInactive",
								strings = { MiniStatusline.section_filename({ trunc_width = nil, path = "tail" }) },
							},
						})
					end,
				},
			})
		end,
	},
}
