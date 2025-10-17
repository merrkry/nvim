return {
	{
		"mason-org/mason.nvim",
		event = "Filetype",
		opts = {},
	},
	{
		"neovim/nvim-lspconfig",
		event = "Filetype",
		dependencies = {
			"mason-org/mason.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			-- lsp actions copied from kickstart.nvim
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- NOTE: Remember that Lua is a real programming language, and as such it is possible
					-- to define small helper and utility functions so you don't have to repeat yourself.
					--
					-- In this case, we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, {
							buffer = event.buf,
							--[[ "LSP: " .. ]]
							desc = desc,
						})
					end

					local fzf = require("fzf-lua")

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("<leader>cr", vim.lsp.buf.rename, "Rename symbol")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>ca", fzf.lsp_code_actions, "Goto code actions", { "n", "x" })

					-- Find references for the word under your cursor.
					map("gr", fzf.lsp_references, "Goto references")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gi", fzf.lsp_implementations, "Goto implementations")

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-t>.
					map("gd", fzf.lsp_definitions, "Goto definitions")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("gD", fzf.lsp_declarations, "Goto declarations")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("<leader>gs", fzf.lsp_document_symbols, "Open document symbol picker")

					-- Fuzzy find all the symbols in your current workspace.
					--  Similar to document symbols, except searches over your entire project.
					map("<leader>gS", fzf.lsp_live_workspace_symbols, "Open workspace symbol picker")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("gy", fzf.lsp_typedefs, "Goto type definitions")

					-- person additions
					map("<leader>d", vim.diagnostic.open_float, "Open floating diagnostics picker")
					map("<leader>gd", fzf.diagnostics_document, "Open document diagnostics picker")
					map("<leader>gD", fzf.diagnostics_workspace, "Open workspace diagnostics picker")

					-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
					---@param client vim.lsp.Client
					---@param method vim.lsp.protocol.Method
					---@param bufnr? integer some lsp support methods only in specific files
					---@return boolean
					local function client_supports_method(client, method, bufnr)
						-- if vim.fn.has 'nvim-0.11' == 1 then
						return client:supports_method(method, bufnr)
						-- else
						-- 	return client.supports_method(method, { bufnr = bufnr })
						-- end
					end

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if
						client
						and client_supports_method(
							client,
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
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

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if
						client
						and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "Toggle inlay hints")

						-- enabled by default
						vim.lsp.inlay_hint.enable(true)
					end
				end,
			})

			-- Some low LSPs, like rust-analyzer, might not be able to display inlay hint right after launch.
			-- We call `inlay_hint.enable` to re-trigger the display of inlay hint after any progress ending.
			vim.api.nvim_create_autocmd("LspProgress", {
				callback = function(event)
					local value = event.data.params.value
					if value.kind == "begin" then
					elseif value.kind == "end" then
						vim.lsp.inlay_hint.enable(vim.lsp.inlay_hint.is_enabled())
					elseif value.kind == "report" then
					end
				end,
			})

			vim.lsp.config("*", {
				capabilities = require("blink-cmp").get_lsp_capabilities(),
			})
		end,
		keys = {
			{
				"<leader>tv",
				function()
					if vim.diagnostic.config().virtual_lines then
						vim.notify("Virtual lines disabled")
						vim.diagnostic.config({ virtual_lines = false })
					else
						vim.notify("Virtual lines enabled")
						vim.diagnostic.config({ virtual_lines = { current_line = true } })
					end
				end,
				desc = "Toggle virtual line",
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		event = "Filetype",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {},
		},
	},
	{
		"j-hui/fidget.nvim",
		event = "Filetype",
		opts = {},
	},
}
