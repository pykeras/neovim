return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim"
    },
    config = function()
        require('neo-tree').setup({
            close_if_last_window = true,
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
                follow_current_file = {
                    enabled = true,
                },
                use_libuv_file_watcher = true,
            },
            window = {
                position = "left",
                width = 40,
            },
        })

        vim.api.nvim_create_autocmd({ "FocusGained", "DirChanged", "BufWritePost" }, {
            callback = function()
                local ok, manager = pcall(require, "neo-tree.sources.manager")
                if not ok then return end

                local ok_state, state = pcall(manager.get_state, "filesystem")
                if not ok_state or not state or not state.path then return end

                local renderer = require("neo-tree.ui.renderer")
                local window_exists = renderer.window_exists(state)
                if window_exists then
                    local current_win = vim.api.nvim_get_current_win()
                    require("neo-tree.command").execute({ command = "refresh" })
                    vim.api.nvim_set_current_win(current_win)
                end
            end,
        })
    end
}
