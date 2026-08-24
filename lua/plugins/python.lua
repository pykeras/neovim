-- Python-specific quality-of-life.
return {
	-- Sticky context header: keeps the enclosing def/class visible while you
	-- scroll inside a long body. Indentation-sensitive languages need this most.
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPost",
		opts = {
			max_lines = 3,
			multiline_threshold = 1,
			trim_scope = "outer",
			mode = "cursor",
			separator = "─",
		},
	},

	-- Scope guides. Python has no braces, so a visual scope marker is not decoration.
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "BufReadPost",
		opts = {
			indent = { char = "│" },
			scope = { enabled = true, show_start = false, show_end = false },
			exclude = {
				filetypes = { "help", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "toggleterm" },
			},
		},
	},

	-- Auto-convert "..." to f"..." the moment you type `{` inside a string.
	{
		"chrisgrieser/nvim-puppeteer",
		lazy = false,
	},

	-- Diagnostics list: workspace-wide errors in one pane instead of file-by-file.
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		opts = { focus = true },
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (workspace)" },
			{ "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (buffer)" },
			{ "<leader>xs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbol outline" },
			{ "<leader>xl", "<cmd>Trouble lsp toggle<cr>", desc = "LSP refs / defs / impls" },
			{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
		},
	},
}
