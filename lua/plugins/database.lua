-- Database client with table/column completion in SQL buffers.
return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		"tpope/vim-dadbod",
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } },
	},
	cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
	init = function()
		vim.g.db_ui_use_nerd_fonts = 1
	end,
	keys = {
		{ "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Database UI" },
	},
}
