require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"vtsls",
		"vue_ls",
		"eslint",
		"tailwindcss",
		"emmet_language_server",
		"lua_ls",
		"hyprls",
		"oxfmt",
		"oxlint",
		"cssls",
		"html",
		"stylua",
		"jsonls",
		"gopls",
	},
	automatic_enable = true,
	automatic_installation = false,
})

vim.diagnostic.config({ virtual_text = true })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("mini.completion").get_lsp_capabilities())

local vue_language_server_path = vim.fn.expand("$MASON/packages")
	.. "/vue-language-server"
	.. "/node_modules/@vue/language-server"
local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vue_language_server_path,
	languages = { "vue" },
	configNamespace = "typescript",
}

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim", "swayimg", "hl" } },
		},
	},
})

vim.lsp.config("vtsls", {
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					vue_plugin,
				},
			},
		},
	},
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

vim.lsp.config("vue_ls", {
	init_options = {
		typescript = {},
	},
	on_attach = function(client)
		client.server_capabilities.semanticTokensProvider.full = true
	end,
})

vim.lsp.enable("markdown_oxide")

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

vim.lsp.config("gopls", {
	settings = {
		gopls = {
			semanticTokens = false,
		},
	},
})

vim.lsp.enable({
	"lua_ls",
	"vtsls",
	"vue_ls",
	"emmet_language_server",
	"gopls",
	"cssls",
	"jsonls",
	"html",
})
