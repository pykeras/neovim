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
		},
		config = function()
			local mason_lspconfig = require("mason-lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- ==========================
			-- Ignore SC2034 in any .env* file
			-- ==========================
			local default_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]

			vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
				if result and result.diagnostics then
					local bufnr = vim.uri_to_bufnr(result.uri)
					local filename = vim.api.nvim_buf_get_name(bufnr)
					if filename:match("[.]env") then
						local filtered = {}
						for _, diag in ipairs(result.diagnostics) do
							if diag.code ~= "SC2034" then
								table.insert(filtered, diag)
							end
						end
						result.diagnostics = filtered
					end
				end
				-- Protect against notify errors
				if vim.fn.exists("g:loaded_noice") == 1 then
					local ok, _ = pcall(default_handler, err, result, ctx, config)
					if not ok then
						return
					end
				else
					default_handler(err, result, ctx, config)
				end
			end

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
				update_in_insert = require("settings").diagnostics.update_in_insert,
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
				"pyrefly",
				"ruff",
				"jsonls",
				"yamlls",
				"dockerls",
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"sqlls",
				"bashls",
				"harper_ls",
			}

			-- mason-lspconfig v2 dropped `handlers`: servers are configured through
			-- vim.lsp.config() and only the ones listed in `servers` are enabled, so a
			-- stray Mason package (pyright, rust-analyzer) never attaches by itself.
			vim.lsp.config("*", { capabilities = capabilities })

			vim.lsp.config("lua_ls", {
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

			vim.lsp.config("ruff", {
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

			vim.lsp.config("pyrefly", {
				settings = {
					pyrefly = {
						displayTypeErrors = true,
						disableLanguageServices = false,
					},
				},
			})

			vim.lsp.config("yamlls", {
				settings = {
					yaml = {
						keyOrdering = false,
						schemaStore = { enable = false, url = "" },
						schemas = require("schemastore").yaml.schemas({
							extra = {
								{
									name = "Docker Compose",
									description = "compose-spec schema",
									fileMatch = {
										"docker-compose.yml",
										"docker-compose.yaml",
										"compose.yml",
										"compose.yaml",
									},
									url = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json",
								},
							},
						}),
					},
				},
			})

			vim.lsp.config("jsonls", {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})

			vim.lsp.config("html", {
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

			vim.lsp.config("cssls", {
				settings = {
					css = {
						validate = true,
						lint = { unknownAtRules = "ignore" },
					},
					less = { validate = true },
					scss = { validate = true },
				},
			})

			-- offline grammar checker
			vim.lsp.config("harper_ls", {
				settings = {
					["harper-ls"] = {
						userDictPath = "",
						fileDictPath = "",
						linters = {
							SpellCheck = true,
							SpelledNumbers = false,
							AnA = true,
							SentenceCapitalization = true,
							UnclosedQuotes = true,
							WrongApostrophe = false,
							LongSentences = true,
							RepeatedWords = true,
							Spaces = true,
							CorrectNumberSuffix = true,
						},
						codeActions = { ForceStable = false },
						markdown = { IgnoreLinkTitle = false },
						diagnosticSeverity = "hint",
						isolateEnglish = false,
						dialect = "American",
						maxFileLength = 120000,
					},
				},
			})

			vim.lsp.config("tailwindcss", {
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

			mason_lspconfig.setup({
				ensure_installed = servers,
				automatic_enable = servers,
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
					"prettierd",
					"pyrefly",
					"stylua",
					"tailwindcss",
					"taplo",
					"buf",
					"sql-formatter",
					"shfmt",
					"shellcheck",
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
		init = function()
			-- Autosave can write while still in insert mode. Formatting then would
			-- strip the empty line just opened, so it's skipped and done on InsertLeave.
			vim.api.nvim_create_autocmd("InsertLeave", {
				group = vim.api.nvim_create_augroup("FormatAfterInsert", { clear = true }),
				callback = function(args)
					if vim.b[args.buf].format_pending then
						vim.b[args.buf].format_pending = false
						require("conform").format({ bufnr = args.buf, timeout_ms = 500, lsp_fallback = true })
					end
				end,
			})
		end,
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				if vim.fn.mode():match("^[iR]") then
					vim.b[bufnr].format_pending = true
					return
				end
				return { timeout_ms = 500, lsp_fallback = true }
			end,
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
				proto = { "buf" },
				sql = { "sql_formatter" },
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
