return {
	"nvim-telescope/telescope.nvim",

	tag = "0.1.8", -- Use the latest stable release
	dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
	}, -- Required dependency
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")
		telescope.load_extension("ui-select")

		telescope.setup({
			defaults = {
				mappings = {
				  n = {
						['l'] = actions.select_default,
						['q'] = actions.close,
            ["dd"] = actions.delete_buffer,
					}
				},
				previewer = false,
				layout_config = {
					horizontal = {
						width = 0.9, -- Adjust the width (90% of the editor width)
						height = 0.8, -- Adjust the height (80% of the editor height)
						preview_width = 0, -- Adjust the preview window width (50% of the Telescope window)
					},
					vertical = {
						width = 0.9, -- Adjust the width (90% of the editor width)
						height = 0.8, -- Adjust the height (80% of the editor height)
						preview_width = 0, -- Adjust the preview window width (50% of the Telescope window)
					},
					width = 0.85, -- Default width for all layouts
					height = 0.75, -- Default height for all layouts
					preview_cutoff = 120, -- Hide preview for small windows
				},
			},
			pickers = {
					current_buffer_fuzzy_find = {
      previewer = false,
    },
				find_files = {
					previewer = false,
					theme = "dropdown",
					layout_config = {
						width = 0.8, -- Specific width for the `find_files` picker
						height = 0.8, -- Specific height for the `find_files` picker
					},
				},
				buffers = {
					previewer = false,
					initial_mode = 'normal',
					theme = "dropdown",
					layout_config = {
						width = 0.8, -- Specific width for the `find_files` picker
						height = 0.8, -- Specific height for the `find_files` picker
					},
				},
				diagnostics = {
					previewer = false,
					initial_mode = 'normal',
					theme = "dropdown",
					layout_config = {
						width = 0.8, -- Specific width for the `find_files` picker
						height = 0.8, -- Specific height for the `find_files` picker
					},
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
				fzf = {
					fuzzy = true,                    -- false will only do exact matching
					override_generic_sorter = true,  -- override the generic sorter
					override_file_sorter = true,     -- override the file sorter
					case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
																					 -- the default case_mode is "smart_case"
				}
			},
		})

		local no_preview = function()
  return require('telescope.themes').get_dropdown({
    width = 0.8,
    previewer = false,
    prompt_title = false
  })
end

		-- Keybindings for common pickers
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find Diagnostics" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Search help tags" })
		vim.keymap.set("n", "<leader>fp", builtin.highlights, { desc = "Search highlights" })
		vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Quick fix" })
	end,
}
