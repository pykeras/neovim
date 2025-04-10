return {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false,   -- This plugin is already lazy
    config = function()
        local mason_reg = require('mason-registry')
        local codelldb = mason_reg.get_package("codelldb")
        local extnsion_path = codelldb:get_install_path() .. "/extension"
        local codelldb_path = extnsion_path .. "/adapter/codelldb"
        local liblldb_path = extnsion_path .. "/lldb/lib/liblldb.so"
        local cfg = require('rustaceanvim.config')
        vim.g.rustaceanvim = {
            dap = {
                adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
            },
            tools = {
                use_telescope = true,
                inlay_hints = {
                    enabled = true,
                }
            }
        }
        vim.lsp.inlay_hint.enable(true)
    end
}
