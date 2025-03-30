return {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    opts = {
        keymap = {
            preset = "enter",
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
            ['<C-e>'] = { 'hide' },
            ["<C-space>"] = { function(cmp) cmp.show({providers = { "lsp", "path", "snippets", "buffer" }}) end },
            ["<C-b>"] = { function(cmp) cmp.scroll_documentation_up(4) end },
            ["<C-f>"] = { function(cmp)cmp.scroll_documentation_down(4) end },
        },
        signature = {
            enabled = true,
            trigger = { show_on_trigger_character = false },
            window = {
                border = "solid",
                scrollbar = false,
                show_documentation = true,
                treesitter_highlighting = true,
            }
        },
        completion = {
            trigger = {
                show_on_keyword = false,
                show_in_snippet = false,
            },
            documentation = {
                window = {
                    border = "solid",
                    scrollbar = false,
                }
            },
            menu = {
                scrollbar = false,
                border = "solid",
                winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
                draw = { treesitter = { "lsp" } }
            }
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" }
        },
        fuzzy = {
            implementation = "rust"
        }
    },
    opts_extend = { "sources.default" }
}
