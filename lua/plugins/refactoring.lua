local function refactor(name)
	return function()
		return require("refactoring")[name]()
	end
end

return {
	-- Extract function / variable, inline variable.
	{
		"ThePrimeagen/refactoring.nvim",
		-- async.nvim is only needed on Neovim 0.12; 0.13 ships it.
		dependencies = { "lewis6991/async.nvim" },
		keys = {
			{ "<leader>rf", refactor("extract_func"), mode = "x", expr = true, desc = "Refactor: extract function" },
			{ "<leader>rv", refactor("extract_var"), mode = "x", expr = true, desc = "Refactor: extract variable" },
			{ "<leader>ri", refactor("inline_var"), mode = { "n", "x" }, expr = true, desc = "Refactor: inline variable" },
			{ "<leader>rr", refactor("select_refactor"), mode = { "n", "x" }, desc = "Refactor: pick from menu" },
		},
	},

	-- Generate a docstring skeleton from the signature under the cursor.
	{
		"danymat/neogen",
		cmd = "Neogen",
		opts = {
			snippet_engine = "nvim",
			languages = {
				python = { template = { annotation_convention = require("settings").docstring_style } },
			},
		},
		keys = {
			{ "<leader>ng", function() require("neogen").generate() end, desc = "Generate docstring" },
		},
	},
}
