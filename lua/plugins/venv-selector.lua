return {
    'linux-cultist/venv-selector.nvim',
    event = 'VeryLazy',
    dependencies = {
        'neovim/nvim-lspconfig',
        'nvim-telescope/telescope.nvim',
        'mfussenegger/nvim-dap-python',
    },
    branch = "regexp",
    config = function()
        local function shorter_name(filename)
            return filename:gsub(os.getenv("HOME"), "~"):gsub("/bin/python", "")
        end
        require('venv-selector').setup {
            options = { on_telescope_result_callback = shorter_name },
            name = { ".venv" },
            auto_refresh = false
        }
    end,
    
}
