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
                require("neo-tree.command").execute({ command = "refresh" })
            end,
        })
    end
}
