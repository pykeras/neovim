return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require('neo-tree').setup({
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
        })

        vim.api.nvim_create_autocmd({ "FocusGained", "DirChanged", "BufWritePost" }, {
            callback = function()
                local manager = require("neo-tree.sources.manager")
                local renderer = require("neo-tree.ui.renderer")
                local state = manager.get_state("filesystem")
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

