return {
    'nvimdev/lspsaga.nvim',
    config = function()
        require('lspsaga').setup({
            lightbulb = { enable = false }
        })
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    }
}
