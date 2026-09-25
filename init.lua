local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("vimops")
require("lazy").setup({
	spec = {
		-- { "folke/tokyonight.nvim", config = function() vim.cmd.colorscheme "tokyonight" end },
		{ import = "plugins" },
	},
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = false,
		notify = false, -- get a notification when changes are found
	},
})
require("keymaps")
require("persian").setup()

local autosave = vim.api.nvim_create_augroup("AutoSave", { clear = true })
local timers = {}

local function save(buf)
	if not vim.api.nvim_buf_is_valid(buf) or not vim.bo[buf].modified then
		return
	end
	if vim.bo[buf].buftype ~= "" or not vim.bo[buf].modifiable then
		return
	end
	if vim.api.nvim_buf_get_name(buf) == "" then
		return
	end
	vim.api.nvim_buf_call(buf, function()
		vim.b.skip_format_on_save = true
		vim.cmd("silent! write")
		vim.b.skip_format_on_save = nil
	end)
end

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "FocusLost", "BufLeave" }, {
	group = autosave,
	pattern = "*",
	callback = function(args)
		local buf = args.buf
		if timers[buf] then
			timers[buf]:stop()
		else
			timers[buf] = vim.uv.new_timer()
		end
		timers[buf]:start(
			1500,
			0,
			vim.schedule_wrap(function()
				save(buf)
			end)
		)
	end,
})

vim.api.nvim_create_autocmd("BufDelete", {
	group = autosave,
	callback = function(args)
		local t = timers[args.buf]
		if t then
			t:stop()
			t:close()
			timers[args.buf] = nil
		end
	end,
})
