-- Persian / RTL support.
--
-- Neovim ships the `persian` keymap and is built with +rightleft +arabic, so
-- nothing needs installing — it just needs wiring up. Everything here is
-- per-buffer on purpose: enabling `rightleft` globally would flip source code
-- too.

local M = {}

-- Characters that only appear in Persian/Arabic script. Used to auto-detect
-- Persian buffers. Range covers Arabic (0600–06FF) plus the Persian-specific
-- letters پ چ ژ گ and the Farsi digits.
local RTL_PATTERN = "[\216-\219][\128-\191]"

--- Turn RTL editing on for a buffer: right-aligned display, Persian keyboard
--- available on <C-^>, and English-only linters silenced.
function M.enable(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_call(bufnr, function()
		-- Deliberately NOT setting `rightleft`. In a terminal it reverses the
		-- character cells itself, which fights the terminal's own bidi and on
		-- VTE (gnome-terminal) blanks the line entirely. Leaving it off keeps
		-- the logical byte order intact and lets the terminal and font do the
		-- reordering — the only thing that produces readable Persian.
		vim.opt_local.rightleft = false
		vim.opt_local.delcombine = true
		-- No Persian dictionary exists for Neovim, so spell would underline
		-- every single word.
		vim.opt_local.spell = false
		-- `persian` maps the standard Iranian layout; <C-^> toggles it in
		-- insert mode without leaving Neovim.
		vim.opt_local.keymap = "persian"
		-- Start in Latin; <C-^> switches to Persian on demand.
		vim.opt_local.iminsert = 0
		vim.opt_local.imsearch = -1
	end)
	vim.b[bufnr].persian_enabled = true
end

--- Restore the buffer to normal LTR editing.
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

--- True if the buffer's first `limit` lines contain a meaningful proportion of
--- Persian characters. A single Persian word in a comment shouldn't flip an
--- entire source file to RTL, so require a run of them.
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

	-- `arabicshape` is global, not buffer-local, so it cannot be part of
	-- enable/disable. Turn it off once here: it makes Neovim substitute
	-- presentation-form glyphs itself and emit them in visual order, which
	-- renders Persian words backwards. Modern terminals and fonts already
	-- shape the text correctly from the logical byte order, so Neovim's
	-- version is redundant at best. It has no effect on Latin text.
	vim.opt.arabicshape = false

	-- Auto-enable for prose buffers that are actually Persian. Restricted to
	-- text filetypes: a .py file with Persian comments stays LTR.
	vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
		group = group,
		pattern = { "*.md", "*.txt", "*.tex", "*.org", "*.rst" },
		callback = function(args)
			if looks_persian(args.buf) then
				M.enable(args.buf)
			end
		end,
	})

	-- Harper is an English grammar checker; on Persian text every sentence is
	-- a false positive. Keep it away from RTL buffers.
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
