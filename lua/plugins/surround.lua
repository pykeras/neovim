return {
    "kylechui/nvim-surround",
    version = "^3.1.1",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({})
    end
}
