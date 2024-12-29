return {
    "hrsh7th/cmp-cmdline",
    config = function()
        local cmp = require("cmp")
        local cmp_cmdline = require("cmp_cmdline")

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "cmdline",  option = { ignore_cmds = { "Man", "!" } } },
                { name = "path" },
            },
        })

        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })
    end
}
