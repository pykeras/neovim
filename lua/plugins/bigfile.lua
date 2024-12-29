return {
    "LunarVim/bigfile.nvim",
    config = function()
        require("bigfile").setup({
            filesize = 2, -- Size in MiB (default)
            pattern = { "*" },
            features = {  -- features to disable for big files
                "indent_blankline",
                "illuminate",
                "lsp",
                "treesitter",
                "syntax",
                "matchparen",
                "vimopts",
                "filetype",
            }
        })
    end
}
