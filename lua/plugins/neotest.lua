-- Test runner: run/debug pytest from inside the editor.
return {
	"nvim-neotest/neotest",
	ft = { "python" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-neotest/nvim-nio",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					-- Follow the venv picked by venv-selector; falls back to $VIRTUAL_ENV.
					runner = "pytest",
					args = { "-vv" },
					dap = { justMyCode = false },
				}),
			},
			output = { open_on_run = false },
			quickfix = { enabled = false },
			status = { virtual_text = true, signs = true },
		})
	end,
}
