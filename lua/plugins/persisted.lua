return {
	"olimorris/persisted.nvim",
	lazy = false, -- Ensure the plugin is always loaded at startup
	config = function()
		require("persisted").setup({
			autosave = true,
			autoload = true,
		})

		-- Autocommand to close neo-tree before saving the session. This is good practice.
		vim.api.nvim_create_autocmd("User", {
			pattern = "PersistedSavePre",
			callback = function()
				-- Use pcall for safety, in case neo-tree isn't open
				pcall(vim.cmd, "Neotree close")
			end,
		})

		-- Autocommand to run after persisted.nvim loads the session.
		vim.api.nvim_create_autocmd("User", {
			pattern = "PersistedLoadPost",
			callback = function()
				vim.cmd("Neotree filesystem show")
				vim.cmd("stopinsert")
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
				vim.cmd("normal! ggzt")
			end,
		})
	end,
}
