return {
	'akinsho/bufferline.nvim',
	event = "VeryLazy",
	dependencies = {
			'nvim-tree/nvim-web-devicons'
	},

	config = function()
			require('bufferline').setup({
					options = {
							always_show_bufferline = true,
							diagnostics = "nvim_lsp",
							diagnostics_indicator = function(count, level, diagnostics_dict, context)
									local s = { error = " ", warn = " ", info = " ", hint = " " }
									local icon = ""
									if level == vim.diagnostic.severity.ERROR then
											icon = s.error
									elseif level == vim.diagnostic.severity.WARN then
											icon = s.warn
									elseif level == vim.diagnostic.severity.INFO then
											icon = s.info
									elseif level == vim.diagnostic.severity.HINT then
											icon = s.hint
									end
									return count > 0 and (icon .. count) or ""
							end,
							offsets = {
									{
											filetype = "neo-tree",
											text = "Explorer",
											text_align = "left",
											separator = true
									}
							},
					}
			})
	end,
}
