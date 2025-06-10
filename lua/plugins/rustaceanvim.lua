return {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false,   -- This plugin is already lazy
    config = function()
        local data = vim.fn.stdpath("data")
        local pkg_base = data .. "/mason/packages/codelldb/extension"
        local codelldb_path = pkg_base .. "/adapter/codelldb"
        local liblldb_path = pkg_base .. "/lldb/lib/liblldb.so"

        local cfg = require('rustaceanvim.config')
        vim.g.rustaceanvim = {
            dap = {
                adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
            },
            tools = {
                use_telescope = true,
                inlay_hints = { enabled = true },
            },
            server = {
                auto_attach = true, -- let rustaceanvim spawn rust-analyzer
            },
        }

        vim.lsp.inlay_hint.enable(true)
    end,
}
