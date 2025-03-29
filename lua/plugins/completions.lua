return {
    'saghen/blink.cmp',
    dependencies = {'rafamadriz/friendly-snippets'},
    version = '1.*',
    opts = {
        keymap = {
            preset = 'super-tab',
            ['<CR>'] = { 'accept', 'fallback' },
            ['<Up>'] = { 'select_prev', 'fallback' },
            ['<Down>'] = { 'select_next', 'fallback' },
            ['<C-e>'] = {},
            ['<C-space>'] = { function(cmp) cmp.show({ providers = {'lsp', 'path', 'snippets', 'buffer'} }) end },
            ['<C-b>'] = { function(cmp) cmp.scroll_documentation_up(4) end },
            ['<C-f>'] = { function(cmp) cmp.scroll_documentation_down(4) end },
        },
        appearance = {
            nerd_font_variant = 'mono'
        },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
                -- treesitter_highlighting = false;
            },
            ghost_text = {
                enabled = false,
                show_with_menu = false,
            },
            menu = {
                draw = {
                    treesitter = { 'lsp' },
                    columns = {
                        { "label", "label_description", gap = 1 },
                        { "kind_icon", "kind" },
                    },
                },
            },
        },
        sources = {
            default = {'lsp', 'path', 'snippets', 'buffer'}
        },
        fuzzy = {
            implementation = "prefer_rust_with_warning"
        }
    },
    opts_extend = {"sources.default"}
}
