return {
    "olimorris/persisted.nvim",
    lazy = false, -- Ensure the plugin is always loaded at startup
    config = function()
        require("persisted").setup({
            autosave = true,
            autoload = true,
        })

        -- Autocommand to close neo-tree before saving the session
        vim.api.nvim_create_autocmd("User", {
            pattern = "PersistedSavePre",
            callback = function()
                vim.cmd("Neotree close")
            end,
        })

        -- Autocommand to open neo-tree after loading the session
        -- vim.api.nvim_create_autocmd("User", {
        --     pattern = "PersistedLoadPost",
        --     callback = function()
        --         vim.cmd("Neotree filesystem show")
        --     end,
        -- })
    end,
}
