return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local ok, ts = pcall(require, "nvim-treesitter")
		if not ok then
			vim.notify("nvim-treesitter not available", vim.log.levels.WARN)
			return
		end

		ts.setup({})

		local parsers = {
			"lua",
			"python",
			"json",
			"yaml",
			"dockerfile",
			"typescript",
			"javascript",
			"tsx",
			"html",
			"css",
			"sql",
			"bash",
		}

		pcall(ts.install, parsers)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = parsers,
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})

		local indent_ft = { "lua", "python", "javascript", "typescript", "tsx", "bash" }
		vim.api.nvim_create_autocmd("FileType", {
			pattern = indent_ft,
			callback = function()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
