local capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
local vue_language_server_path = "/usr/lib/node_modules/@vue/typescript-plugin/"

local customizations = {
	{ rule = "style/*",   severity = "off", fixable = true },
	{ rule = "format/*",  severity = "off", fixable = true },
	{ rule = "*-indent",  severity = "off", fixable = true },
	{ rule = "*-spacing", severity = "off", fixable = true },
	{ rule = "*-spaces",  severity = "off", fixable = true },
	{ rule = "*-order",   severity = "off", fixable = true },
	{ rule = "*-dangle",  severity = "off", fixable = true },
	{ rule = "*-newline", severity = "off", fixable = true },
	{ rule = "*quotes",   severity = "off", fixable = true },
	{ rule = "*semi",     severity = "off", fixable = true },
}

return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"vtsls",
					"volar",
					"emmet_language_server",
					"tailwindcss",
					"jsonls"
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.emmet_language_server.setup({
				filetypes = {
					"css",
					"eruby",
					"html",
					"javascript",
					"javascriptreact",
					"less",
					"sass",
					"scss",
					"pug",
					"typescriptreact",
					"vue",
					"eslint-lsp",
				},
			})
			lspconfig.vtsls.setup({
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
				settings = {
					complete_function_calls = true,
					vtsls = {
						enableMoveToFileCodeAction = true,
						autoUseWorkspaceTsdk = true,
						experimental = {
							completion = {
								enableServerSideFuzzyMatch = true,
							},
						},
						tsserver = {
							globalPlugins = {
								{
									name = "@vue/typescript-plugin",
									location = vue_language_server_path,
									languages = { "vue" },
									configNamespace = "typescript",
									enableForWorkspaceTypeScriptVersions = true,
								},
							},
						},
					},
					typescript = {
						updateImportsOnFileMove = { enabled = "always" },
						suggest = {
							completeFunctionCalls = true,
						},
						inlayHints = {
							parameterNames = { enabled = "literals" },
							parameterTypes = { enabled = false },
							variableTypes = { enabled = false },
							propertyDeclarationTypes = { enabled = false },
							functionLikeReturnTypes = { enabled = true },
							enumMemberValues = { enabled = true },
						},
					},
				},
			})
			lspconfig.jsonls.setup({})
			lspconfig.tailwindcss.setup({})
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using (most
							-- likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
							-- Tell the language server how to find Lua modules same way as Neovim
							-- (see `:h lua-module-load`)
							path = {
								"lua/?.lua",
								"lua/?/init.lua",
							},
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								-- Depending on the usage, you might want to add additional paths
								-- here.
								-- '${3rd}/luv/library'
								-- '${3rd}/busted/library'
							},
							-- Or pull in all of 'runtimepath'.
							-- NOTE: this is a lot slower and will cause issues when working on
							-- your own configuration.
							-- See https://github.com/neovim/nvim-lspconfig/issues/3189
							-- library = {
							--   vim.api.nvim_get_runtime_file('', true),
							-- }
						},
					},
				},
			})
			lspconfig.html.setup({})
			lspconfig.cssls.setup({})
			lspconfig.biome.setup({})
			lspconfig.volar.setup({
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
				init_options = {
					vue = {
						-- disable hybrid mode
						hybridMode = false,
					},
				},
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
			})
			lspconfig.eslint.setup({
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"vue",
					"html",
					"markdown",
					"json",
					"jsonc",
					"yaml",
					"toml",
					"xml",
					"gql",
					"graphql",
					"astro",
					"svelte",
					"css",
					"less",
					"scss",
					"pcss",
					"postcss",
				},
				settings = {
					-- Silent the stylistic rules in you IDE, but still auto fix them
					rulesCustomizations = customizations,
				},
			})
		end,
	},
}
