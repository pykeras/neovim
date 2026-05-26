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
	end,
}
