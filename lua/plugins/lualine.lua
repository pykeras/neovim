return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
			require("lualine").setup({
					options = {
							theme = "dracula",
					},
			})
	end,
}
