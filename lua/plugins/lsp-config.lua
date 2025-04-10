return {
    -- Mason: Installer for LSP servers and tools
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    -- Mason-LSPConfig: Auto-installer for LSP servers
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "pyright", "ruff", "rust_analyzer" },
            })
        end
    },
    -- NVIM-LSPConfig: LSP server configurations using blink-cmp capabilities
    {
        "neovim/nvim-lspconfig",
        dependencies = { 'saghen/blink.cmp' },
        config = function()
            local capabilities = require('blink-cmp').get_lsp_capabilities()
            local lspconfig = require("lspconfig")
            vim.diagnostic.config({
                signs = true,            -- Enable signs (icons in the sign column)
                underline = true,        -- Enable underlining diagnostics
                update_in_insert = true, -- update diagnostics in insert mode (can be distracting)
                severity_sort = true,    -- Sort diagnostics by severity

                -- Configure floating window for diagnostics (to enable wrapping)
                float = {
                    border = "rounded",
                    source = true,
                    options = {
                        wrap = true,       -- <<< Enable wrapping within the float
                        linebreak = false, -- <<< Enable wrapping at word boundaries
                    }
                },
                virtual_text = false, -- Set to true to keep truncated inline messages
            })
            -- Customize diagnostic signs (requires Nerd Font)
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            -- Lua
            lspconfig.lua_ls.setup({
                on_attach = function(_, bufnr)
                    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
                end,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                            path = vim.split(package.path, ';'),
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })
            -- Pyright
            lspconfig.pyright.setup({
                on_attach = function(_, _)
                    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                        vim.lsp.diagnostic.on_publish_diagnostics, {
                            virtual_text = true,
                            signs = true,
                            update_in_insert = true,
                        }
                    )
                end,
                on_init = function(client)
                    local root_dir = client.config.root_dir
                    local venv_path = root_dir .. "./venv"
                    if vim.fn.isdirectory(venv_path) == 1 then
                        client.config.settings.python.pythonPath = venv_path .. "/bin/python3"
                    end
                end,
                filetype = { "python" },
                capabilities = capabilities,
                settings = {
                    pyright = { disableOrganizeImports = true },
                    python = {
                        analysis = {
                            typeCheckingMode = "off",
                            diagnosticMode = "workspace",
                            typeCheckingBehavior = "strict",
                            reportMissingType = true,
                            reportUnusedImport = false,
                            reportUnusedVariable = false,
                        },
                    },
                },
            })
            -- Rust
            lspconfig.rust_analyzer.setup({
                on_attach = function(_, bufnr)
                    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
                end,
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        assist = { importGranularity = "module", importPrefix = "by_self" },
                        cargo = { allFeatures = true },
                        procMacro = { enable = true },
                    },
                },
            })
            -- Ruff
            lspconfig.ruff.setup({
                on_attach = function(_, bufnr)
                    vim.keymap.set("n", "<leader>rf", function()
                        vim.lsp.buf.format({ async = false }) -- true: This causes a problem where the file must be saved multiple times.
                    end, { buffer = bufnr, desc = "Format with Ruff" })
                end,
                capabilities = capabilities,
                init_options = {
                    settings = {
                        showSyntaxErrors = true,
                        lint = {
                            extendSelect = { "I" }
                        }
                    }
                }
            })

            --
            -- Common autocommand: disable ruff hover
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client and client.name == "ruff" then
                        client.server_capabilities.hoverProvider = false
                    end
                end,
                desc = "Disable hover for Ruff",
            })
            -- run Ruff autofix on save
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.py",
                callback = function()
                    local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() }) -- deprecated: but still do the job
                    local ruff_client = nil
                    for _, client in pairs(clients) do
                        if client.name == "ruff" then
                            ruff_client = client
                            break
                        end
                    end

                    if ruff_client then
                        vim.lsp.buf.code_action({
                            context = { only = { "source.fixAll" } },
                            apply = true,
                            action_handler = function(action)
                                if action.command then
                                    action.command.arguments = { "--extend-select", "I" }
                                end
                                vim.lsp.buf.execute_command(action.command)
                            end,
                        })
                    else
                        vim.notify("Ruff LSP not available ...", vim.log.levels.WARN)
                    end
                end,
                desc = "Run Ruff autofix and format on save for Python files",
            })
            -- Auto-format on saving any LSP client that supports formatting
            vim.api.nvim_create_autocmd("BufWritePre", {
                callback = function()
                    vim.lsp.buf.format({
                        async = false, -- true: This causes a problem where the file must be saved multiple times.
                        filter = function(client)
                            return client.supports_method("textDocument/formatting")
                        end,
                    })
                end,
                desc = "Auto-format on save with specific LSP clients",
            })
        end
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.diagnostics.mypy.with({
                        extra_args = { "--strict", "--show-error-codes", "--exclude", ".venv" },
                    }),
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        local augroup = vim.api.nvim_create_augroup("null_ls_formatting", { clear = true })
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end
                end,
            })
        end,
    },
}
