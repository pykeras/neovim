-- Persian / RTL support. Per-buffer on purpose: enabling it globally would
-- flip source code too.

local M = {}

-- UTF-8 lead bytes for the Arabic block (U+0600–U+06FF).
local RTL_PATTERN = "[\216-\219][\128-\191]"

function M.enable(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_call(bufnr, function()
		-- `rightleft` reverses cells itself, fighting the terminal's bidi and
		-- blanking lines on VTE. Let the terminal do the reordering.
		vim.opt_local.rightleft = false
		vim.opt_local.delcombine = true
		-- No Persian dictionary ships with Neovim.
		vim.opt_local.spell = false
		-- Standard Iranian layout; <C-^> toggles it in insert mode.
		vim.opt_local.keymap = "persian"
		vim.opt_local.iminsert = 0
		vim.opt_local.imsearch = -1
	end)
	vim.b[bufnr].persian_enabled = true
end

function M.disable(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_call(bufnr, function()
		vim.opt_local.rightleft = false
		vim.opt_local.keymap = ""
		vim.opt_local.iminsert = 0
		vim.opt_local.spell = true
	end)
	vim.b[bufnr].persian_enabled = false
end

function M.toggle(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	if vim.b[bufnr].persian_enabled then
		M.disable(bufnr)
		vim.notify("Persian mode: off", vim.log.levels.INFO)
	else
		M.enable(bufnr)
		vim.notify("Persian mode: on — <C-^> toggles the keyboard in insert mode", vim.log.levels.INFO)
	end
end

-- Require several Persian lines so one word in a comment can't flip a file.
local function looks_persian(bufnr, limit)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, limit or 50, false)
	local hits = 0
	for _, line in ipairs(lines) do
		if line:find(RTL_PATTERN) then
			hits = hits + 1
			if hits >= 3 then
				return true
			end
		end
	end
	return false
end

function M.setup()
	local group = vim.api.nvim_create_augroup("PersianSupport", { clear = true })

	-- Global, so it can't live in enable/disable. Neovim's own shaping emits
	-- glyphs in visual order, rendering Persian backwards; terminals do it right.
	vim.opt.arabicshape = false

	-- Prose filetypes only: a .py file with Persian comments stays LTR.
	vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
		group = group,
		pattern = { "*.md", "*.txt", "*.tex", "*.org", "*.rst" },
		callback = function(args)
			if looks_persian(args.buf) then
				M.enable(args.buf)
			end
		end,
	})

	-- Harper only checks English; on Persian every sentence is a false positive.
	vim.api.nvim_create_autocmd("LspAttach", {
		group = group,
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client and client.name == "harper_ls" and vim.b[args.buf].persian_enabled then
				vim.lsp.buf_detach_client(args.buf, args.data.client_id)
			end
		end,
	})

	vim.api.nvim_create_user_command("Persian", function()
		M.toggle()
	end, { desc = "Toggle Persian/RTL mode for this buffer" })

	vim.keymap.set("n", "<leader>rtl", function()
		M.toggle()
	end, { desc = "Toggle Persian / RTL mode" })
end

return M
