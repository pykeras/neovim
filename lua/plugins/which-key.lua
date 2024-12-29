return {
    "folke/which-key.nvim",
    dependencies = { "echasnovski/mini.icons" },
    event = "VeryLazy",
    config = function()
        require("which-key").setup({
            plugins = {
                spelling = {
                    enabled = true,
                    suggestions = 10,
                },
                presets = {
                    operators = true,
                    motions = true,
                    text_objects = true,
                    windows = true,
                    nav = true,
                },
            },
        })
    end,
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
