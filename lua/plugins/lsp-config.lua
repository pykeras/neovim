return {
	-- Mason: Installer for LSP servers and tools
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- Mason-LSPConfig: Manages LSP installation and setup
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"b0o/schemastore.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")
			local capabilities = require("blink-cmp").get_lsp_capabilities()

			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = " ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
				underline = true,
				update_in_insert = true,
				severity_sort = true,
				virtual_text = true,
				float = {
					border = "rounded",
					source = "if_many",
					focusable = false,
					close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre", "WinLeave" },
					format = function(diagnostic)
						return diagnostic.message
					end,
					options = {
						wrap = true,
						linebreak = false,
					},
				},
			})

			local servers = {
				"lua_ls",
				"pyright",
				"ruff",
				"jsonls",
				"yamlls",
				"dockerls",
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
			}

			mason_lspconfig.setup({
				ensure_installed = servers,
				handlers = {
					function(server_name)
						lspconfig[server_name].setup({
							capabilities = capabilities,
						})
					end,
					["lua_ls"] = function()
						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									runtime = { version = "LuaJIT" },
									diagnostics = { globals = { "vim" } },
									workspace = {
										library = vim.api.nvim_get_runtime_file("", true),
										checkThirdParty = false,
									},
									telemetry = { enable = false },
								},
							},
						})
					end,
					["pyright"] = function()
						lspconfig.pyright.setup({
							on_init = function(client)
								local root_dir = client.config.root_dir
								local venv_path = root_dir and (root_dir .. "/.venv") or ""
								if vim.fn.isdirectory(venv_path) == 1 then
									client.config.settings.python.pythonPath = venv_path .. "/bin/python3"
								end
							end,
							filetypes = { "python" },
							capabilities = capabilities,
							settings = {
								python = {
									analysis = {
										typeCheckingMode = "off",
										autoSearchPaths = true,
										useLibraryCodeForTypes = true,
										diagnosticMode = "openFilesOnly",
									},
								},
							},
						})
					end,
					["ruff"] = function()
						lspconfig.ruff.setup({
							capabilities = capabilities,
							on_attach = function(client, bufnr)
								client.server_capabilities.hoverProvider = false
								client.server_capabilities.documentFormattingProvider = false
								client.server_capabilities.documentRangeFormattingProvider = false
								vim.keymap.set("n", "rf", function()
									require("conform").format({ bufnr = bufnr })
								end, { buffer = bufnr, desc = "Format with Conform" })
							end,
							settings = {
								lint = {
									extendSelect = { "I" },
								},
							},
						})
					end,
					["jsonls"] = function()
						lspconfig.jsonls.setup({
							capabilities = capabilities,
							settings = {
								json = {
									schemas = require("schemastore").json.schemas(),
									validate = { enable = true },
								},
							},
						})
					end,

					["html"] = function()
						lspconfig.html.setup({
							capabilities = capabilities,
							settings = {
								html = {
									hover = { documentation = true, references = true },
									validate = { scripts = true },
									suggest = {
										completeAttributeTags = true,
										completeTags = true,
										snippetsPreventDoubleInsertion = false,
									},
								},
							},
						})
					end,
					["cssls"] = function()
						lspconfig.cssls.setup({
							capabilities = capabilities,
							settings = {
								css = {
									validate = true,
									lint = { unknownAtRules = "ignore" },
								},
								less = { validate = true },
								scss = { validate = true },
							},
						})
					end,
					["tailwindcss"] = function()
						lspconfig.tailwindcss.setup({
							capabilities = capabilities,
							settings = {
								tailwindCSS = {
									classAttributes = { "class", "className", "ngClass", ":class", "classList" },
									lint = {
										incompatibleProperty = "error",
										invalidApply = "error",
										invalidConfigPath = "error",
										invalidScreen = "error",
										invalidVariant = "error",
										recommendedVariantOrder = "warning",
									},
									validate = true,
									experimental = {
										classRegex = {
											"class:['\"]([^'\"]*)['\"]",
											"class:['\"]([^'\"]*)['\"]",
											"class=\\{([^\\}]*)\\}",
											"class=([^\\s>]+)",
											"class:(.*?)[^\\S]",
											"class=([^\\s>]+)",
										},
									},
								},
							},
							init_options = {
								userLanguages = {
									eelixir = "html-eex",
									eruby = "erb",
								},
							},
						})
					end,
				},
			})
		end,
	},

	-- none-ls for Mypy diagnostics with per-project venv detection
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")

			-- Helper: look for ./.venv/bin/mypy, else fall back to PATH
			local function find_mypy()
				local cwd = vim.fn.getcwd()
				local venv_mypy = cwd .. "/.venv/bin/mypy"
				if vim.fn.executable(venv_mypy) == 1 then
					return venv_mypy
				end
				return "mypy"
			end

			null_ls.setup({
				sources = {
					null_ls.builtins.diagnostics.mypy.with({
						command = find_mypy(),
						extra_args = { "--strict", "--show-error-codes" },
					}),
				},
			})
		end,
	},

	-- Mason-tool-installer for non-LSP tools ⚙️
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"mypy",
					"prettierd",
					"stylua",
					"tailwindcss",
					"taplo",
				},
				auto_update = false,
				run_on_start = true,
				start_delay = 1000,
			})
		end,
	},

	-- Formatting with conform.nvim
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format", "ruff_fix" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				css = { "prettierd" },
				scss = { "prettierd" },
				html = { "prettierd" },
				json = { "prettierd" },
				jsonl = { "prettierd" },
				yaml = { "prettierd" },
				rust = { "rustfmt" },
				toml = { "taplo" },
			},
			formatters = {
				ruff_format = {
					command = "ruff",
					args = { "format", "$FILENAME" },
					stdin = false,
				},
				ruff_fix = {
					command = "ruff",
					args = { "check", "--exit-zero", "--fix", "--extend-select", "I", "--", "$FILENAME" },
					stdin = false,
				},
			},
		},
	},
}
