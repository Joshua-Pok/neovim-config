return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- Solves the CMP capability gotcha:
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- 1. Initialize Mason
		require("mason").setup()

		-- 2. Setup LSP Attach Autocommands
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				local builtin = require("telescope.builtin")
				map("grr", builtin.lsp_references, "[G]oto [R]eferences")
				map("gri", builtin.lsp_implementations, "[G]oto [I]mplementation")
				map("grd", builtin.lsp_definitions, "[G]oto [D]efinition")
				map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("gO", builtin.lsp_document_symbols, "Open Document Symbols")
				map("gW", builtin.lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
				map("grt", builtin.lsp_type_definitions, "[G]oto [T]ype Definition")

				local client = vim.lsp.get_client_by_id(event.data.client_id)

				-- Document Highlights
				if client and client:supports_method("textDocument/documentHighlight", event.buf) then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})
					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				-- Inlay Hints
				if client and client:supports_method("textDocument/inlayHint", event.buf) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")

					local inlay_hints_group = vim.api.nvim_create_augroup("LSP_inlayHints", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						group = inlay_hints_group,
						buffer = event.buf,
						callback = function()
							local row = vim.api.nvim_win_get_cursor(0)[1]
							vim.lsp.inlay_hint.enable(true, {
								bufnr = event.buf,
								filter = function(hint)
									return hint.position.line + 1 == row
								end,
							})
						end,
					})
				end
			end,
		})

		-- 3. Broadcast capabilities to servers
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- 4. Define Server Configurations
		local servers = {
			clangd = {},
			gopls = {
				settings = {
					gopls = {
						gofumpt = true,
						codelenses = {
							gc_details = false,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						analyses = {
							fieldalignment = true,
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
						},
						usePlaceholders = true,
						completeUnimported = true,
						staticcheck = true,
						directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
						semanticTokens = true,
					},
				},
			},
			pyright = {
				settings = {
					python = {
						analysis = {
							autoImportCompletions = true,
							autoSearchPaths = true,
							diagnosticMode = "workspace",
							useLibraryCodeForTypes = true,
						},
					},
				},
			},
			ruff = {},
			ts_ls = {
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
						suggest = { includeCompletionsForModuleExports = true, autoImports = true },
						preferences = { includePackageJsonAutoImports = "auto" },
					},
					javascript = {
						suggest = { includeCompletionsForModuleExports = true, autoImports = true },
						preferences = { includePackageJsonAutoImports = "auto" },
					},
				},
			},
			eslint = {},
			html = {},
			cssls = {},
			lua_ls = {
				settings = { Lua = { completion = { callSnippet = "Replace" } } },
			},
		}

		-- 5. Setup Mason Tool Installer & LspConfig Handlers
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, { "stylua" })

		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			ensure_installed = {},
			automatic_installation = false,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
