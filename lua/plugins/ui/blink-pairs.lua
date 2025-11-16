return {
	{
		"saghen/blink.pairs",
		version = "1.*",
		build = "nix run .#build-plugin",
		event = "VeryLazy",
		config = function()
			local C = require("catppuccin.palettes").get_palette("frappe")

			-- https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/rainbow_delimiters.lua
			vim.api.nvim_set_hl(0, "PairsRed", { fg = C.red })
			vim.api.nvim_set_hl(0, "PairsYellow", { fg = C.yellow })
			vim.api.nvim_set_hl(0, "PairsBlue", { fg = C.blue })
			vim.api.nvim_set_hl(0, "PairsOrange", { fg = C.peach })
			vim.api.nvim_set_hl(0, "PairsGreen", { fg = C.green })
			vim.api.nvim_set_hl(0, "PairsViolet", { fg = C.mauve })
			vim.api.nvim_set_hl(0, "PairsCyan", { fg = C.teal })

			vim.api.nvim_set_hl(0, "BlinkPairsUnmatched", {
				fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg,
				bg = C.red,
			})

			vim.api.nvim_set_hl(0, "BlinkPairsMatchParen", {
				fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg,
				bg = C.grey,
			})

			require("blink.pairs").setup({
				highlights = {
					groups = {
						"PairsRed",
						"PairsYellow",
						"PairsBlue",
						"PairsOrange",
						"PairsGreen",
						"PairsViolet",
						"PairsCyan",
					},
					matchparen = {
						include_surrounding = true,
					},
				},
			})
		end,
	},
}
