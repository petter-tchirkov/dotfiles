return {
	{
		"mason-org/mason.nvim",
		build = ":MasonUpdate",
		opts = {},
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
			"yioneko/nvim-vtsls",
			"nvim-lua/plenary.nvim",
		},
		opts = {},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"vtsls",
					"vue_ls",
					"eslint",
					"tailwindcss",
					"emmet_language_server",
					"lua_ls",
					"hyprls",
				},
				automatic_enable = true,
				automatic_installation = false,
			})

			vim.lsp.config("tailwindcss", {
				filetypes = {
					"aspnetcorerazor",
					"astro",
					"astro-markdown",
					"blade",
					"clojure",
					"django-html",
					"htmldjango",
					"edge",
					"eelixir",
					"elixir",
					"ejs",
					"erb",
					"eruby",
					"gohtml",
					"gohtmltmpl",
					"haml",
					"handlebars",
					"hbs",
					"html",
					"htmlangular",
					"html-eex",
					"heex",
					"jade",
					"leaf",
					"liquid",
					"markdown",
					"mdx",
					"mustache",
					"njk",
					"nunjucks",
					"php",
					"razor",
					"slim",
					"twig",
					"css",
					"less",
					"postcss",
					"sass",
					"scss",
					"stylus",
					"sugarss",
					"javascript",
					"javascriptreact",
					"reason",
					"rescript",
					"typescript",
					"typescriptreact",
					"vue",
					"svelte",
					"templ",
				},
				{
					tailwindCSS = {
						classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
						includeLanguages = {
							eelixir = "html-eex",
							elixir = "phoenix-heex",
							eruby = "erb",
							heex = "phoenix-heex",
							htmlangular = "html",
							templ = "html",
						},
						lint = {
							cssConflict = "warning",
							invalidApply = "error",
							invalidConfigPath = "error",
							invalidScreen = "error",
							invalidTailwindDirective = "error",
							invalidVariant = "error",
							recommendedVariantOrder = "warning",
						},
						validate = true,
					},
				},
			})

			vim.lsp.config("hyprls", {})

			-- vim.lsp.config("vue_ls", {
			-- 	filetypes = { "vue" },
			-- })

			vim.lsp.config("vtsls", {
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"vue",
				},
				settings = {
					vtsls = { tsserver = { globalPlugins = {} } },
					typescript = {
						inlayHints = {
							parameterNames = { enabled = "literals" },
							parameterTypes = { enabled = true },
							variableTypes = { enabled = true },
							propertyDeclarationTypes = { enabled = true },
							functionLikeReturnTypes = { enabled = true },
							enumMemberValues = { enabled = true },
						},
					},
				},
				before_init = function(_, config)
					table.insert(config.settings.vtsls.tsserver.globalPlugins, {
						name = "@vue/typescript-plugin",
						location = vim.fn.expand(
							"$MASON/packages/vue-language-server/node_modules/@vue/language-server"
						),
						languages = { "vue" },
						configNamespace = "typescript",
						enableForWorkspaceTypeScriptVersions = true,
					})
				end,
				on_attach = function(client)
					client.server_capabilities.documentFormattingProvider = true
					client.server_capabilities.documentRangeFormattingProvider = true
				end,
			})

			vim.lsp.config("emmet_language_server", {
				on_attach = function(client, bufnr)
					vim.keymap.set("i", "<c-s>,", function()
						client.request(
							"textDocument/completion",
							vim.lsp.util.make_position_params(0, client.offset_encoding),
							function(_, result)
								local textEdit = result.items[1].textEdit
								local snip_string = textEdit.newText
								textEdit.newText = ""
								vim.lsp.util.apply_text_edits({ textEdit }, bufnr, client.offset_encoding)
								require("luasnip").lsp_expand(snip_string)
							end,
							bufnr
						)
					end, { noremap = true, buffer = bufnr, desc = "Expand emmet" })
				end,
			})

			vim.lsp.config("lua_ls", {
				on_attach = function(client)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
				settings = {
					Lua = {
						workspace = {
							checkThirdParty = false,
						},
						completion = {
							callSnippet = "Replace",
						},
						telemetry = {
							enable = false,
						},
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			vim.keymap.set("n", "gq", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", {}),
				callback = function(event)
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					local map = function(keys, func, desc, mode)
						vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					local fzf = require("fzf-lua")

					map("gd", function()
						fzf.lsp_definitions({ jump1 = true })
					end, "[G]oto [D]efinition")
					map("gD", function()
						fzf.lsp_definitions({ jump1 = false })
					end, "Peek [D]efinition")
					map("grr", fzf.lsp_references, "[G]oto [R]eferences")
					map("g<c-d>", fzf.lsp_typedefs, "Type [D]efinition")
					map("<leader>ds", fzf.lsp_document_symbols, "[D]ocument [S]ymbols")
					map("<leader>ws", fzf.lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")
					map("gra", fzf.lsp_code_actions, "Code [A]ction")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					if
						client
						and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if
						client
						and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})
		end,
	},
}
