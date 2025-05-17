-- Kanagawa Theme (Original)
return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		compile = true,
		undercurl = true,
		background = {
			light = "lotus",
			dark = "wave", -- "wave, dragon"
		},
		colors = {
			theme = {
				all = {
					ui = {
						bg_gutter = "none",
					},
				},
			},
		},
		overrides = function(colors)
			local theme = colors.theme
			local makeDiagnosticColor = function(color)
				local c = require("kanagawa.lib.color")
				return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
			end
			return {
				NormalFloat = { bg = "none" },
				FloatBorder = { bg = "none" },
				FloatTitle = { bg = "none" },

				-- Save an hlgroup with dark background and dimmed foreground
				-- so that you can use it where your still want darker windows.
				-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
				NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

				-- Popular plugins that open floats will link to NormalFloat by default;
				-- set their background accordingly if you wish to keep them dark and borderless
				LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
				MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

				Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
				PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
				PmenuSbar = { bg = theme.ui.bg_m1 },
				PmenuThumb = { bg = theme.ui.bg_p2 },

				TelescopeTitle = { fg = theme.ui.special, bold = true },
				TelescopePromptNormal = { bg = theme.ui.bg_p1 },
				TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
				TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
				TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
				TelescopePreviewNormal = { bg = theme.ui.bg_dim },
				TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

				DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
				DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
				DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
				DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),

				DiagnosticFloatingError = { bg = theme.ui.bg_dim, fg = theme.diag.error },
				Float = { bg = theme.ui.bg_dim },

				MiniIndentscopeSymbol = { fg = theme.ui.fg_dim },
				IndentBlanklineChar = { link = "NormalFloat" },
			}
		end,
	},
	config = function(_, opts)
		require("kanagawa").setup(opts) -- Replace this with your favorite colorscheme
		vim.cmd("colorscheme kanagawa") -- Replace this with your favorite colorscheme
	end,
	build = function()
		vim.cmd("KanagawaCompile")
	end,
}
