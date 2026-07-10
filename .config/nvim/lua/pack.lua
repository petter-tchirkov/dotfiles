vim.pack.add({
	"https://github.com/mikavilpas/yazi.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/akinsho/bufferline.nvim",
	"https://github.com/f4z3r/gruvbox-material.nvim",
	"https://github.com/rmagatti/auto-session",
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/rafamadriz/friendly-snippets",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/enochchau/nvim-pretty-ts-errors",
	"https://github.com/m4xshen/autoclose.nvim",
	"https://github.com/carlos-algms/agentic.nvim",
	"https://github.com/saghen/blink.lib",
	"https://github.com/saghen/blink.cmp",
	"https://github.com/echasnovski/mini.icons",
	"https://github.com/akinsho/toggleterm.nvim",
	"https://github.com/brenoprata10/nvim-highlight-colors",
})

local MiniPick = require("mini.pick")
local MiniExtra = require("mini.extra")
MiniPick.setup()
MiniExtra.setup()

vim.keymap.set("n", "<leader>ff", function()
	MiniPick.builtin.files()
end, { desc = "Mini File Picker" })
vim.keymap.set("n", "<leader>fg", function()
	MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") })
end, { desc = "Grep word/Search word" })
vim.keymap.set("n", "<leader>fh", function()
	MiniPick.builtin.help()
end, { desc = "Mini Help" })

vim.keymap.set("n", "<leader>fd", function()
	MiniExtra.pickers.diagnostic()
end, { desc = "Mini Picker Diagnostics" })
vim.keymap.set("n", "<leader>fk", function()
	MiniExtra.pickers.keymaps()
end, { desc = "Search keymaps" })

require("yazi").setup({
	open_for_directories = true,
})

require("auto-session").setup({
	suppressed_dirs = { "~/", "~/Downloads", "/" },
})

require("mini.notify").setup({
	content = {
		format = function(notif)
			return notif.msg
		end,
	},
})

local MiniSnippets = require("mini.snippets")
MiniSnippets.setup({
	snippets = {
		MiniSnippets.gen_loader.from_lang(),
	},
})
MiniSnippets.start_lsp_server({ match = false })

require("mini.surround").setup()

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = require("gruvbox-material.lualine").theme("hard"),
		-- theme = "gruvbox-material",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
			refresh_time = 16, -- ~60fps
			events = {
				"WinEnter",
				"BufEnter",
				"BufWritePost",
				"SessionLoadPost",
				"FileChangedShellPost",
				"VimResized",

				"CursorMoved",
				"CursorMovedI",
				"ModeChanged",
			},
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_y = { "progress" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		truncate_names = false,
	},
})

require("gruvbox-material").setup({
	contrast = "hard",
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "oxfmt" },
		javascriptreact = { "oxfmt" },
		typescript = { "oxfmt" },
		typescriptreact = { "oxfmt" },
		json = { "oxfmt" },
		vue = { "oxfmt" },
		html = { "oxfmt" },
		css = { "oxfmt" },
		scss = { "oxfmt" },
		jsonc = { "oxfmt" },
		go = { "gofumpt" },
		gomod = { "gofumpt" },
		gowork = { "gofumpt" },
		gotmpl = { "gofumpt" },
		conf = { "shfmt" },
	},
})

require("autoclose").setup({
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
})

require("agentic").setup({
	provider = "codex-acp", -- setting the name here is all you need to get started
})

require("blink.cmp").build():pwait()
require("blink.cmp").setup({
	keymap = {
		preset = "enter",
		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
	},
	completion = {
		documentation = {
			auto_show = true,
		},
		list = {
			selection = { preselect = false, auto_insert = true },
		},
		border = nil,
		menu = {
			scrollbar = false,
			scrolloff = 1,
			auto_show = true,
			draw = {
				components = {
					kind_icon = {
						text = function(ctx)
							local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
							return kind_icon
						end,
						-- (optional) use highlights from mini.icons
						highlight = function(ctx)
							local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
							return hl
						end,
					},
					kind = {
						-- (optional) use highlights from mini.icons
						highlight = function(ctx)
							local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
							return hl
						end,
					},
				},
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind_icon", "kind", gap = 1 },
				},
			},
		},
	},
	signature = {
		enabled = false,
	},
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},
	cmdline = {
		enabled = true,
		keymap = {
			preset = "enter",
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
		},
		completion = {
			menu = {
				auto_show = false,
				scrollbar = false,
				scrolloff = 1,
			},
		},
	},
	sources = {
		default = { "lsp", "path", "buffer", "snippets" },
		providers = {
			cmdline = {
				min_keyword_length = 0,
			},
			omni = {
				module = "blink.cmp.sources.complete_func",
				enabled = function()
					return vim.bo.omnifunc ~= "v:lua.vim.lsp.omnifunc"
				end,
				opts = {
					complete_func = function()
						return vim.bo.omnifunc
					end,
				},
			},
		},
	},
})

require("nvim-highlight-colors").setup({})

require("toggleterm").setup({
	size = 13,
	open_mapping = [[<c-s-\>]],
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = "1",
	start_in_insert = true,
	persist_size = true,
	-- direction = "float",
})
