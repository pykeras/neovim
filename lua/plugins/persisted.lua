return {
	"olimorris/persisted.nvim",
	lazy = false,
	config = function()
		require("persisted").setup({
			autosave = true,
			autoload = true,
		})

		-- Before session save: remember neo-tree state and close it to avoid saving the window
		vim.api.nvim_create_autocmd("User", {
			pattern = "PersistedSavePre",
			callback = function()
				local was_open = false
				local ok, state = pcall(function()
					return require("neo-tree.sources.manager").get_state("filesystem")
				end)
				if ok and state then
					was_open = true
					pcall(vim.cmd, "Neotree close")
				end
				vim.g.neo_tree_was_open = was_open and 1 or 0
			end,
		})

		-- After session load: restore neo-tree if it was open, and perform your cleanup
		vim.api.nvim_create_autocmd("User", {
			pattern = "PersistedLoadPost",
			callback = function()
				vim.schedule(function()
					if vim.g.neo_tree_was_open == 1 then
						if pcall(vim.cmd, "Neotree") then
							pcall(vim.cmd, "Neotree show")
						end
					end
					vim.cmd("stopinsert")
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
					vim.cmd("normal! ggzt")
				end)
			end,
		})
	end,
}
