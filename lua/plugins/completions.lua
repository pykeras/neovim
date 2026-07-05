return {
	"saghen/blink.cmp",
	version = "1.*",
	dependencies = { "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip" },
	opts = {
		keymap = { preset = "enter" },
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
	},
	opts_extend = { "sources.default" },
}
