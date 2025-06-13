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
				ensure_installed = {
					"lua_ls",
					"pyright",
					"ruff",
					"jsonls",
					"yamlls",
					"dockerls",
				},
			})
		end,
	},

	-- mason-tool-installer for non-LSP tools ⚙️
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"mypy",
					"prettierd",
					"stylua",
				},
				auto_update = false,
				run_on_start = true,
				start_delay = 3000,
			})
		end,
	},

	{ "b0o/schemastore.nvim" },

	-- NVIM-LSPConfig: LSP server configurations
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		config = function()
			local capabilities = require("blink-cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")

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
				-- virtual_text = false,
				virtual_text = true,
				float = {
					border = "rounded",
					source = true,
					format = function(diagnostic)
						return diagnostic.message
					end,
					options = {
						wrap = true,
						linebreak = false,
					},
				},
			})

			-- Lua
			lspconfig.lua_ls.setup({
				on_attach = function(_, bufnr)
					vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
				end,
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			})

			-- Pyright
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
							typeCheckingMode = "on",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
						},
					},
				},
			})

			-- Ruff
			lspconfig.ruff.setup({
				on_attach = function(client, bufnr)
					client.server_capabilities.hoverProvider = false
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false

					vim.keymap.set("n", "<leader>rf", function()
						require("conform").format({ bufnr = bufnr })
					end, { buffer = bufnr, desc = "Format with Conform" })
				end,
				settings = {
					lint = {
						extendSelect = { "I" },
					},
				},
				capabilities = capabilities,
			})

			-- JSON LSP configuration
			lspconfig.jsonls.setup({
				capabilities = capabilities,
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})

			-- Docker
			lspconfig.dockerls.setup({ capabilities = capabilities })
		end,
	},

	-- Linting with nvim-lint
	-- {
	-- 	"mfussenegger/nvim-lint",
	-- 	event = { "BufReadPre", "BufNewFile" },
	-- 	config = function()
	-- 		local lint = require("lint")
	--
	-- 		lint.linters_by_ft = {
	-- 			python = { "mypy" },
	-- 		}
	--
	-- 		-- Dynamically configure mypy to use the project's virtual environment
	-- 		lint.linters.mypy = {
	-- 			-- Use a function to build the arguments dynamically
	-- 			fn_args = function(opts)
	-- 				-- Find the virtual environment directory
	-- 				local venv_path = vim.fn.findup(".venv", opts.fname .. ";")
	--
	-- 				local args = {
	-- 					"--strict",
	-- 					"--show-error-codes",
	-- 					"--exclude",
	-- 					".venv",
	-- 				}
	--
	-- 				-- If a .venv is found, tell mypy to use its python executable
	-- 				if venv_path and venv_path ~= "" then
	-- 					table.insert(args, "--python-executable")
	-- 					table.insert(args, venv_path .. "/bin/python3")
	-- 				end
	--
	-- 				-- Add the filename to be linted at the end
	-- 				table.insert(args, opts.fname)
	-- 				return args
	-- 			end,
	-- 		}
	--
	-- 		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	-- 			group = vim.api.nvim_create_augroup("linting_au", { clear = true }),
	-- 			callback = function(args)
	-- 				lint.try_lint(nil, { bufnr = args.buf })
	-- 			end,
	-- 		})
	-- 	end,
	-- },

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
				-- This single formatter will fix lint errors (including isort) and format the code.
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
			},
			-- Define the custom ruff_fix formatter
			formatters = {
				-- 1. A formatter that ONLY runs 'ruff format'
				ruff_format = {
					command = "ruff",
					args = { "format", "--", "$FILENAME" },
					stdin = false,
				},
				-- 2. A formatter that runs 'ruff check --fix'
				ruff_check_fix = {
					command = "ruff",
					-- The --extend-select I argument ensures import sorting is always applied.
					-- 'check --fix' applies all fixable lint rules.
					args = { "check", "--fix", "--extend-select", "I", "--", "$FILENAME" },
					stdin = false,
				},
			},
		},
	},
}
