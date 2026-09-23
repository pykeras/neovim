return {
	"mrcjkb/rustaceanvim",
	version = "^6", -- Recommended
	lazy = false, -- This plugin is already lazy
	config = function()
		local data = vim.fn.stdpath("data")
		local pkg_base = data .. "/mason/packages/codelldb/extension"
		local codelldb_path = pkg_base .. "/adapter/codelldb"
		local liblldb_path = pkg_base .. "/lldb/lib/liblldb.so"

		local cfg = require("rustaceanvim.config")
		vim.g.rustaceanvim = {
			server = {
				capabilities = require("blink-cmp").get_lsp_capabilities(),
				default_settings = {
					["rust-analyzer"] = {
						cargo = { buildScripts = { enable = true } },
						procMacro = { enable = true },
						-- clippy is much slower than `cargo check`. Give it its own
						-- target dir so it does not invalidate the build cache
						-- `cargo build` shares.
						check = {
							command = "clippy",
							extraArgs = { "--target-dir", "target/rust-analyzer" },
						},
						checkOnSave = true,
						diagnostics = { enable = true },
					},
				},
			},
			dap = {
				adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
			},
			tools = {
				use_telescope = true,
				inlay_hints = { enabled = true },
			},
		}

		vim.lsp.inlay_hint.enable(true)
	end,
}
