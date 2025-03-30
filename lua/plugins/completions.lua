return {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    opts = {
        keymap = {
            preset = "super-tab",
            ["<CR>"] = { "accept", "fallback" },
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<C-e>"] = {},
            ["<C-space>"] = {
                function(cmp)
                    cmp.show(
                        {
                            providers = { "lsp", "path", "snippets", "buffer" }
                        }
                    )
                end
            },
            ["<C-b>"] = {
                function(cmp)
                    cmp.scroll_documentation_up(4)
                end
            },
            ["<C-f>"] = {
                function(cmp)
                    cmp.scroll_documentation_down(4)
                end
            }
        },
        appearance = {
            nerd_font_variant = "mono"
        },
        signature = {
            enabled = false,
            trigger = {
                enabled = false,
            },
            window = {
                min_width = 1,
                max_width = 100,
                max_height = 10,
                border = "solid",
                scrollbar = false,
                show_documentation = true,
                treesitter_highlighting = true
            }
        },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
                update_delay_ms = 50,
                -- treesitter_highlighting = false;
                window = {
                    border = "solid",
                    min_width = 10,
                    max_width = 80,
                    max_height = 20,
                    winblend = 0,
                    winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
                    scrollbar = false,
                }
            },
            ghost_text = {
                enabled = false,
                show_with_menu = false,
            },
            menu = {
                scrollbar = false,
                border = "solid",
                winhighlight =
                "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
                draw = {
                    align_to = "label",
                    padding = 1,
                    gap = 1,
                    treesitter = { "lsp" },
                    columns = {
                        { "kind_icon" },
                        {
                            "label",
                            "label_description",
                            gap = 1
                        }
                    },
                    components = {
                        kind_icon = {
                            ellipsis = false,
                            text = function(ctx)
                                return ctx.kind_icon .. ctx.icon_gap
                            end,
                            highlight = function(ctx)
                                return ctx.kind_hl
                            end
                        },
                        kind = {
                            ellipsis = false,
                            width = {
                                fill = true
                            },
                            text = function(ctx)
                                return ctx.kind
                            end,
                            highlight = function(ctx)
                                return ctx.kind_hl
                            end
                        },
                        label = {
                            width = {
                                fill = true,
                                max = 60
                            },
                            text = function(ctx)
                                return ctx.label .. ctx.label_detail
                            end,
                            highlight = function(ctx)
                                local highlights = {
                                    {
                                        0,
                                        #ctx.label,
                                        group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel"
                                    }
                                }
                                if ctx.label_detail then
                                    table.insert(
                                        highlights,
                                        {
                                            #ctx.label,
                                            #ctx.label + #ctx.label_detail,
                                            group = "BlinkCmpLabelDetail"
                                        }
                                    )
                                end

                                for _, idx in ipairs(ctx.label_matched_indices) do
                                    table.insert(
                                        highlights,
                                        {
                                            idx,
                                            idx + 1,
                                            group = "BlinkCmpLabelMatch"
                                        }
                                    )
                                end

                                return highlights
                            end
                        },
                        label_description = {
                            width = {
                                max = 30
                            },
                            text = function(ctx)
                                return ctx.label_description
                            end,
                            highlight = "BlinkCmpLabelDescription"
                        },
                        source_name = {
                            width = {
                                max = 30
                            },
                            text = function(ctx)
                                return ctx.source_name
                            end,
                            highlight = "BlinkCmpSource"
                        },
                        source_id = {
                            width = {
                                max = 30
                            },
                            text = function(ctx)
                                return ctx.source_id
                            end,
                            highlight = "BlinkCmpSource"
                        }
                    }
                }
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
