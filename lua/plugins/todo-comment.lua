return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("todo-comments").setup({
			keywords = {
				BUG = { icon = " ", color = "error", alt = { "FIXME", "bug" } },
				FEATURE = { icon = " ", color = "feature", alt = { "feature" } },
				INFO = { icon = " ", color = "info", alt = { "info" } },
				TODO = { icon = " ", color = "todo", alt = { "todo" } },
				FIXME = { icon = " ", color = "fix", alt = { "fixme" } },
				FUTURE = { icon = " ", color = "future", alt = { "future" } },
				DEBUG = { icon = " ", color = "debug", alt = { "debug" } },
				DELETE = { icon = " ", color = "delete", alt = { "delete" } },
				ATTENTION = { icon = " ", color = "attention", alt = { "attention" } },
				PROBLEM = { icon = " ", color = "problem", alt = { "problem" } },
				SOLUTION = { icon = " ", color = "solution", alt = { "solution" } },
				COMMAND = { icon = " ", color = "command", alt = { "command" } },
				CHECKED = { icon = " ", color = "checked", alt = { "checked" } },
				ISSUE = { icon = " ", color = "issue", alt = { "issue" } },
				EXPLAIN = { icon = " ", color = "explain", alt = { "explain" } },
			},
			colors = {
				error = { "#ff0544" },
				feature = { "#35ff11" },
				info = { "#6a9918" },
				todo = { "#388aa6" },
				fix = { "#ca3ecf" },
				future = { "#003050" },
				debug = { "#B73A3A" },
				delete = { "#ff6342" },
				attention = { "#f576ee" },
				problem = { "#f74545" },
				solution = { "#02ed1a" },
				command = { "#00f7ca" },
				checked = { "#a7f757" },
				issue = { "#ba0262" },
				explain = { "#A0E7E5" },
			},
			search = {
				command = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--ignore-case",
				},
				pattern = [[\b(KEYWORDS):]], -- ripgrep regex
			},
		})
	end,
}
