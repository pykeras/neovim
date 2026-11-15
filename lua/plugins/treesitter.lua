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

		-- The legacy `master` branch registers this directive expecting a single
		-- node, but Neovim 0.12 passes a list. Without the override every fenced
		-- code block in markdown (hover, completion docs) throws in get_range().
		if pcall(require, "nvim-treesitter.query_predicates") then
			vim.treesitter.query.add_directive("set-lang-from-info-string!", function(match, _, source, pred, metadata)
				local node = match[pred[2]]
				if type(node) == "table" then
					node = node[#node]
				end
				if not node then
					return
				end
				local alias = vim.treesitter.get_node_text(node, source):lower()
				local ft = vim.filetype.match({ filename = "a." .. alias })
				metadata["injection.language"] = vim.treesitter.language.get_lang(ft or alias) or alias
			end, { force = true })
		end

		local parsers = {
			"lua",
			"python",
			"rust",
			"toml",
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

		-- NOTE: python is intentionally excluded — nvim-treesitter's (main branch)
		-- indent module is still experimental and mis-handles Python, which caused
		-- Enter to jump to column 0 with no indent. Neovim's builtin Python indent
		-- (indent/python.vim) + autoindent works far better, so we let it handle .py.
		local indent_ft = { "lua", "javascript", "typescript", "tsx", "bash" }
		vim.api.nvim_create_autocmd("FileType", {
			pattern = indent_ft,
			callback = function()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
