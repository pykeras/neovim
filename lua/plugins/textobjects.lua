-- Treesitter text objects: select/move/swap by function, class, argument, loop.
-- This is what makes editing Python structural instead of line-based.
return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = { lookahead = true },
			move = { set_jumps = true },
		})

		local select = require("nvim-treesitter-textobjects.select")
		local move = require("nvim-treesitter-textobjects.move")
		local swap = require("nvim-treesitter-textobjects.swap")

		-- Select: af/if = function, ac/ic = class, aa/ia = argument, al/il = loop
		local selections = {
			["af"] = "@function.outer",
			["if"] = "@function.inner",
			["ac"] = "@class.outer",
			["ic"] = "@class.inner",
			["aa"] = "@parameter.outer",
			["ia"] = "@parameter.inner",
			["al"] = "@loop.outer",
			["il"] = "@loop.inner",
			["ai"] = "@conditional.outer",
			["ii"] = "@conditional.inner",
			["a/"] = "@comment.outer",
		}
		for lhs, capture in pairs(selections) do
			vim.keymap.set({ "x", "o" }, lhs, function()
				select.select_textobject(capture, "textobjects")
			end, { desc = "Select " .. capture })
		end

		-- Move: ]f / [f next-previous function start, ]c / [c class, ]a argument
		local moves = {
			[")m"] = { "@function.outer", "next_start" },
			["]f"] = { "@function.outer", "next_start" },
			["]F"] = { "@function.outer", "next_end" },
			["]c"] = { "@class.outer", "next_start" },
			["]a"] = { "@parameter.inner", "next_start" },
		}
		for lhs, spec in pairs(moves) do
			vim.keymap.set({ "n", "x", "o" }, lhs, function()
				move["goto_" .. spec[2]](spec[1], "textobjects")
			end, { desc = "Next " .. spec[1] })
		end
		local moves_prev = {
			["[f"] = { "@function.outer", "previous_start" },
			["[F"] = { "@function.outer", "previous_end" },
			["[c"] = { "@class.outer", "previous_start" },
			["[a"] = { "@parameter.inner", "previous_start" },
		}
		for lhs, spec in pairs(moves_prev) do
			vim.keymap.set({ "n", "x", "o" }, lhs, function()
				move["goto_" .. spec[2]](spec[1], "textobjects")
			end, { desc = "Previous " .. spec[1] })
		end

		-- Swap arguments: reorder function parameters without retyping them.
		vim.keymap.set("n", "<leader>sa", function()
			swap.swap_next("@parameter.inner")
		end, { desc = "Swap argument with next" })
		vim.keymap.set("n", "<leader>sA", function()
			swap.swap_previous("@parameter.inner")
		end, { desc = "Swap argument with previous" })
	end,
}
