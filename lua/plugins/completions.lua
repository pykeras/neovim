local settings = require("settings").completion

-- Home-row keys on top of the preset: <C-j>/<C-k> move through the menu and
-- <Tab> accepts, so neither the arrow keys nor Enter are needed.
local keymap = {
	preset = settings.enter_accepts and "enter" or "super-tab",
	["<C-j>"] = { "select_next", "fallback" },
	-- With the menu closed <C-k> toggles blink's own signature window. It only
	-- falls back to the plain LSP float when signature_help is switched off.
	["<C-k>"] = { "select_prev", "show_signature", "hide_signature", "fallback" },
	["<Tab>"] = {
		function(cmp)
			if cmp.snippet_active() then
				return cmp.accept()
			end
			return cmp.select_and_accept()
		end,
		"snippet_forward",
		"fallback",
	},
}

return {
	"saghen/blink.cmp",
	version = "1.*",
	dependencies = { "rafamadriz/friendly-snippets" },
	opts = {
		keymap = keymap,
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		completion = {
			accept = { auto_brackets = { enabled = settings.auto_brackets } },
			documentation = { auto_show = settings.auto_docs, auto_show_delay_ms = 300 },
			ghost_text = { enabled = settings.ghost_text },
		},
		signature = {
			enabled = settings.signature_help,
			-- Also show it when entering insert mode inside a call, while typing
			-- an argument, and after accepting a function from the menu.
			trigger = { show_on_insert = true, show_on_keyword = true, show_on_accept = true },
		},
	},
	opts_extend = { "sources.default" },
}
