local M = {}

local document_highlight = "textDocument/documentHighlight"
local inlay_hints = vim.lsp.inlay_hint

---@param bufnr integer
---@return boolean
local function inlay_hint_preference(bufnr)
	local override = vim.b[bufnr].lsp_inlay_hints
	if override ~= nil then
		return override
	end
	local config = require("lang").by_ft()[vim.bo[bufnr].filetype]
	if config and config.inlayHints ~= nil then
		return config.inlayHints
	end
	return inlay_hints.is_enabled()
end

local function setup_keymaps()
	-- :help lsp-defaults
	for _, key in ipairs({ "gra", "gri", "grn", "grr", "grt", "grx", "gO" }) do
		vim.keymap.del("n", key)
	end
	vim.keymap.del({ "i", "s" }, "<C-S>")

	-- Reference: https://docs.helix-editor.com/keymap.html
	local pickers = {
		{ "gd", "lsp_definitions", "Go to definitions" },
		{ "gD", "lsp_declarations", "Go to declarations" },
		{ "gy", "lsp_type_definitions", "Go to type definitions" },
		{ "gr", "lsp_references", "Go to references" },
		{ "gi", "lsp_implementations", "Go to implementations" },
		{ "gai", "lsp_incoming_calls", "Open incoming calls picker" },
		{ "gao", "lsp_outgoing_calls", "Open outgoing calls picker" },
		{ "<leader>s", "lsp_symbols", "Open document symbol picker" },
		{ "<leader>S", "lsp_workspace_symbols", "Open workspace symbol picker" },
	}
	for _, mapping in ipairs(pickers) do
		local key, source, desc = unpack(mapping)
		vim.keymap.set("n", key, function()
			Snacks.picker(source)
		end, { desc = desc })
	end

	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol" })
	vim.keymap.set("n", "<leader>A", vim.lsp.codelens.run, { desc = "Run codelens command" })
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover information" })

	vim.keymap.set("n", "<localleader>H", function()
		local bufnr = vim.api.nvim_get_current_buf()
		local enabled = not inlay_hint_preference(bufnr)
		vim.b[bufnr].lsp_inlay_hints = enabled
		inlay_hints.enable(enabled, { bufnr = bufnr })
	end, { desc = "Toggle inlay hints" })
end

local function setup_buffers()
	local group = vim.api.nvim_create_augroup("LspBufferSetup", {})
	local highlights = vim.api.nvim_create_augroup("LspCursorHighlight", {})

	vim.api.nvim_create_autocmd({ "FileType", "LspAttach" }, {
		group = group,
		callback = function(event)
			local filter = { bufnr = event.buf }
			local enabled = inlay_hint_preference(event.buf)
			if inlay_hints.is_enabled(filter) ~= enabled then
				inlay_hints.enable(enabled, filter)
			end
		end,
	})

	vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach" }, {
		group = group,
		callback = function(event)
			local bufnr = event.buf
			local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
			if not client:supports_method(document_highlight, bufnr) then
				return
			end

			local clients = vim.lsp.get_clients({ bufnr = bufnr, method = document_highlight })
			local has_other_client = vim.iter(clients):any(function(attached)
				return attached.id ~= client.id
			end)
			if has_other_client then
				return
			end

			if event.event == "LspDetach" then
				vim.lsp.util.buf_clear_references(bufnr)
				vim.api.nvim_clear_autocmds({ group = highlights, buf = bufnr })
				return
			end

			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group = highlights,
				buf = bufnr,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				group = highlights,
				buf = bufnr,
				callback = vim.lsp.buf.clear_references,
			})
		end,
	})
end

function M.setup()
	setup_keymaps()

	inlay_hints.enable(true)
	setup_buffers()

	-- Highlight `{}` and `{var}` in Rust format strings.
	vim.api.nvim_set_hl(0, "@lsp.type.formatSpecifier.rust", { link = "@punctuation.bracket" })
	vim.api.nvim_set_hl(0, "@lsp.type.variable.rust", { link = "@variable" })

	vim.lsp.config("*", {
		capabilities = require("blink.cmp").get_lsp_capabilities(),
		before_init = function(_, config)
			require("codesettings").with_local_settings(config.name, config)
		end,
	})
	vim.lsp.log.set_level(vim.log.levels.OFF)
	vim.lsp.enable(require("lang").default_lsps())
end

return M
