---@diagnostic disable: missing-fields
return {
	{
		"saghen/blink.cmp",
		lazy = true,
		dependencies = {
			"folke/lazydev.nvim",
			{ "L3MON4D3/LuaSnip", version = "v2.*" },
			"rafamadriz/friendly-snippets",
		},
		event = "InsertEnter",
		version = "v1.*",
		opts = {
			keymap = {
				preset = "enter",
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab"] = { "select_prev", "fallback" },
			},
			completion = {
				documentation = {
					auto_show = true,
				},
				border = nil,
				scrolloff = 1,
				scrollbar = false,
				menu = {
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
			},
			snippets = { preset = "luasnip" },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				providers = {
					cmdline = {
						min_keyword_length = 2,
					},
				},
			},
		},
		opts_extend = {
			"sources.default",
			"sources.completion.enabled_providers",
		},
	},
}
