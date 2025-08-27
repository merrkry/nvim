return {
	{
		"ThePrimeagen/harpoon",
		event = "VeryLazy",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			harpoon:setup({
				settings = {
					save_on_toggle = true,
					sync_on_ui_close = true,
				},
			})

			-- Usage of HarpoonList see harpoon/lua/harpoon/list.lua
			local list = harpoon:list()

			for i = 1, 9, 1 do
				vim.keymap.set("n", string.format("<leader>%d", i), function()
					list:select(i)
				end, {
					desc = string.format("Jump to harpoon buffer %d", i),
				})
				vim.keymap.set("n", string.format("<leader>h%d", i), function()
					list:replace_at(i)
				end, {
					desc = string.format("Set buffer to harpoon %d", i),
				})
			end

			vim.api.nvim_set_hl(0, "NormalFloat", { fg = "none", bg = "none" })
			vim.api.nvim_set_hl(0, "FloatBorder", { fg = "none", bg = "none" })
			vim.keymap.set("n", "<leader>H", function()
				harpoon.ui:toggle_quick_menu(list, {
					border = "rounded",
					title_pos = "center",
					ui_width_ratio = 0.40,
				})
			end, { desc = "Open harpoon floating menu" })

			vim.keymap.set("n", "<leader>ha", function()
				list:add()
			end, { desc = "Add buffer to Harpoon" })
			vim.keymap.set("n", "<leader>hc", function()
				list:clear()
			end, { desc = "Clear harpoon buffers" })

			local function harpoon_reorder()
				local item_stack = {}
				for _, item in pairs(list.items) do
					table.insert(item_stack, item)
				end
				for idx, item in ipairs(item_stack) do
					list:replace_at(idx, item)
				end
			end
			vim.keymap.set("n", "<leader>hr", harpoon_reorder, { desc = "Reorder harpoon buffers" })

			-- local fzf = require("fzf-lua")
			-- local function fzf_harpoon()
			-- 	local string_to_id = {}
			-- 	local id_to_string = {}
			--
			-- 	-- The table is expected to be very small, should be fine to recreate frequently.
			-- 	local function refresh()
			-- 		local function clear_table(t)
			-- 			for k in pairs(t) do
			-- 				t[k] = nil
			-- 			end
			-- 		end
			-- 		clear_table(string_to_id)
			-- 		clear_table(id_to_string)
			--
			-- 		local harpoon_files = list
			-- 		for _, item in pairs(harpoon_files.items) do
			-- 			local _, id = list:get_by_value(item.value)
			-- 			if id ~= nil then
			-- 				local item_str = string.format("[%d] %s", id, item.value)
			-- 				string_to_id[item_str] = id
			-- 				id_to_string[id] = item_str
			-- 			end
			-- 		end
			-- 	end
			--
			-- 	local function swap_item(x, y) end
			--
			-- 	refresh()
			--
			-- 	fzf.fzf_exec(id_to_string, {
			-- 		exec_empty_query = true,
			-- 		actions = {
			-- 			["default"] = function(selected)
			-- 				local id = string_to_id[selected[1]]
			-- 				list:select(id)
			-- 			end,
			-- 			["ctrl-o"] = {
			-- 				fn = function(selected)
			-- 					local id = string_to_id[selected[1]]
			-- 					list:remove_at(id)
			-- 					refresh()
			-- 				end,
			-- 				reload = true,
			-- 			},
			-- 			["ctrl-r"] = {
			-- 				fn = function()
			-- 					harpoon_reorder()
			-- 					refresh()
			-- 				end,
			-- 				reload = true,
			-- 			},
			-- 			-- TODO: swap items?
			-- 		},
			-- 	})
			-- end
			-- vim.keymap.set("n", "<leader>H", function()
			-- 	fzf_harpoon()
			-- end, { desc = "Open harpoon picker" })
		end,
	},
}
