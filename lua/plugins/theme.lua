-- 	{
-- 		"rebelot/kanagawa.nvim",
-- 		name = "kanagawa",
-- 	},
-- 	{
-- 		"savq/melange",
-- 		name = "melange",
-- 	},
--
-- 	-- Theme switcher plugin
-- 	{
-- 		"zaldih/themery.nvim",
-- 		lazy = false,
-- 		config = function()
-- 			require("themery").setup({
-- 				themes = {
-- 					"catppuccin",
-- 					"tokyonight",
-- 					"kanagawa",
-- 					"melange",
-- 				},
-- 				default = "catppuccin",
-- 				livePreview = true,
-- 			})
-- 		end,
-- 	},
-- }
--

return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
	},
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
	},
	{
		"savq/melange",
		name = "melange",
	},
	{
		"sainnhe/gruvbox-material",
		name = "gruvbox-material",
	},
	{
		"EdenEast/nightfox.nvim",
		name = "nightfox",
	},
	{
		"navarasu/onedark.nvim",
		name = "onedark",
	},

	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			require("themery").setup({
				themes = {
					-- Catppuccin
					"catppuccin-frappe",
					"catppuccin-macchiato",
					"catppuccin-mocha",
					-- Tokyonight
					"tokyonight-night",
					"tokyonight-storm",
					"tokyonight-moon",
					-- Kanagawa
					"kanagawa-wave",
					"kanagawa-dragon",
					-- Melange
					"melange",
					-- Gruvbox Material
					"gruvbox-material",
					-- Nightfox
					"nightfox",
					"carbonfox",
					-- One Dark
					"onedark",
					-- light
					"tokyonight-day",
					"catppuccin-latte",
					"dayfox",
					"kanagawa-lotus",
				},
				default = "tokyonight-night",
				livePreview = true,
			})
		end,
	},
}
