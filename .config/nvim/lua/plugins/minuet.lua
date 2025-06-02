return {
	"milanglacier/minuet-ai.nvim",
	config = function()
		require("minuet").setup({
			-- Your configuration options here
			provider = "openai_fim_compatible",
			context_window = 512,
			n_completions = 1,
			provider_options = {
				gemini = {
					optional = {
						generationConfig = {
							maxOutputTokens = 256,
							thinkingConfig = {
								thinkingBudget = 0,
							},
						},
					},
				},
				openai_fim_compatible = {
					api_key = "TERM",
					name = "Ollama",
					end_point = "http://localhost:11434/v1/completions",
					model = "qwen2.5-coder:7b",
					optional = {
						max_tokens = 56,
						top_p = 0.9,
					},
				},
			},
			virtualtext = {
				keymap = {
					-- accept whole completion
					accept = "<A-f>",
					-- accept one line
					accept_line = "<C-f>",
					-- accept n lines (prompts for number)
					-- e.g. "A-z 2 CR" will accept 2 lines
					accept_n_lines = "<A-z>",
					-- Cycle to prev completion item, or manually invoke completion
					prev = "<A-[>",
					-- Cycle to next completion item, or manually invoke completion
					next = "<A-]>",
					dismiss = "<A-e>",
				},
				auto_trigger_ft = { "lua", "vue", "typescript" },
				show_on_completion_menu = false,
			},
		})
	end,
}
