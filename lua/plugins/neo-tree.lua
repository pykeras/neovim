return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			enable_session_for_tree = false,
			close_if_last_window = false,
			components = {
				git_status = {
					symbols = {
						added = "A",
						deleted = "D",
						modified = "M",
						renamed = "R",
						staged = "S",
						conflict = "C",
						untracked = "U",
					},
				},
			},
			filesystem = {
				enable_file_watcher = true,
				filtered_items = { visible = true, hide_dotfiles = false, hide_gitignored = false },
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			window = {
				position = "left",
				width = 40,
				auto_refresh_on_change = true,
			},
		})

		-- Safe refresh: do nothing if the filesystem tree isn’t open
		local function safe_refresh()
			local state = require("neo-tree.sources.manager").get_state("filesystem")
			if state then
				require("neo-tree.command").execute({ command = "refresh" })
			end
		end

		local NeotreeRefreshGroup = vim.api.nvim_create_augroup("NeotreeRefreshGroup", { clear = true })

		vim.api.nvim_create_autocmd("FocusGained", {
			group = NeotreeRefreshGroup,
			callback = safe_refresh,
		})

		vim.api.nvim_create_autocmd("WinLeave", {
			group = NeotreeRefreshGroup,
			callback = function(event)
				if vim.v.dying > 0 then
					return
				end
				if vim.bo[event.buf].buftype == "terminal" then
					safe_refresh()
				end
			end,
		})
	end,
}
