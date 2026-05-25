return {
	{
		"junegunn/fzf.vim",
		dependencies = { "junegunn/fzf", build = "./install --all" },
		config = function()
			local function calculate_distance(rel_path)
				if not rel_path:match("/") then
					return 0
				end
				local dir = vim.fn.fnamemodify(rel_path, ":h")
				local count = 0
				for _ in dir:gmatch("[^/]+") do
					count = count + 1
				end
				return count
			end

			local function files_with_proximity()
				local current_file = vim.fn.expand("%:p")
				if current_file == "" then
					vim.notify("No file is open.", vim.log.levels.WARN)
					return
				end
				local current_dir = vim.fn.fnamemodify(current_file, ":h")

				local git_dir = vim.fn.finddir(".git", current_dir .. ";" .. os.getenv("HOME"))
				if git_dir == "" then
					vim.notify("Could not find a .git directory in any parent up to $HOME.", vim.log.levels.ERROR)
					return
				end
				local project_root = vim.fn.fnamemodify(git_dir, ":h")

				local rel_current_dir = current_dir:sub(#project_root + 2)
				local parent_prefix = vim.fn.fnamemodify(rel_current_dir, ":h")

				local command = string.format('rg --files "%s" 2>/dev/null', project_root)
				local files = vim.fn.systemlist(command)
				if vim.v.shell_error ~= 0 or #files == 0 then
					vim.notify("Failed to generate file list or project is empty.", vim.log.levels.ERROR)
					return
				end

				local items = {}
				for _, abs_path in ipairs(files) do
					local rel = abs_path:sub(#project_root + 2)
					local dist = calculate_distance(rel)

					local display
					if parent_prefix ~= "" and rel:find("^" .. vim.pesc(parent_prefix) .. "/") then
						display = rel:sub(#parent_prefix + 2)
					else
						display = rel
					end

					table.insert(items, {
						full_rel = rel,
						display = display,
						distance = dist,
					})
				end

				table.sort(items, function(a, b)
					if a.distance ~= b.distance then
						return a.distance < b.distance
					end
					return a.display < b.display
				end)

				local fzf_source = {}
				for _, item in ipairs(items) do
					table.insert(fzf_source, item.display .. "\t" .. item.full_rel)
				end

				vim.fn["fzf#run"](vim.fn["fzf#wrap"]({
					source = fzf_source,
					sink = function(line)
						local full_rel = line:match("\t(.+)$")
						if full_rel then
							vim.cmd("edit " .. project_root .. "/" .. full_rel)
						end
					end,
					options = '--delimiter "\\t" --with-nth 1 --prompt "Files (proximity) > "',
				}))
			end

			vim.api.nvim_create_user_command("FZFFilesProximity", files_with_proximity, {})
		end,
	},
}
