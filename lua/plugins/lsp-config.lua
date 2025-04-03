return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "pyright", "ruff" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local lspconfig = require("lspconfig")

            lspconfig.lua_ls.setup({
                on_attach = function(client, bufnr)
                    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
                end,
                capabilities = capabilities,
            })

            lspconfig.pyright.setup({
                on_attach = function(client, bufnr)
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
                    local venv_path = root_dir .. "/.venv"
                    if vim.fn.isdirectory(venv_path) == 1 then
                        client.config.settings.python.pythonPath = venv_path .. "/bin/python"
                    end
                end,
                filetype = { "python" },
                settings = {
                    pyright = {
                        disableOrganizeImports = true,
                    },
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

            lspconfig.ruff.setup({
                on_attach = function(client, bufnr)
                    vim.keymap.set("n", "<leader>rf", function()
                        vim.lsp.buf.format({ async = true })
                    end, { buffer = bufnr, desc = "Format with Ruff" })
                end,
                init_options = {
                    settings = {
                        showSyntaxErrors = true,
                        lint = {
                            extendSelect = { "I" }
                        }
                    }
                }
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client == nil then
                        return
                    end
                    if client.name == "ruff" then
                        client.server_capabilities.hoverProvider = false
                    end
                end,
                desc = "LSP: Disable hover capability from Ruff",
            })

            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.py",
                callback = function()
                    local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
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

            vim.api.nvim_create_autocmd("BufWritePre", {
                callback = function()
                    vim.lsp.buf.format({
                        async = false,
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
                        extra_args = { "--strict", "--show-error-codes" },
                    }),
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
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
