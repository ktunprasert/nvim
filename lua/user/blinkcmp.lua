local accept = function(n)
	return function(cmp)
		cmp.accept(n)
	end
end

local keymaps = {
	preset = "enter",
	["<C-k>"] = { "select_prev", "fallback_to_mappings" },
	["<C-j>"] = { "select_next", "fallback_to_mappings" },
	["<CR>"] = { "accept", "fallback_to_mappings" },
	["<Tab>"] = { "snippet_forward", "select_next" },
	["<S-Tab>"] = { "snippet_backward", "select_prev" },
	["<A-1>"] = { accept(1) },
	["<A-2>"] = { accept(2) },
	["<A-3>"] = { accept(3) },
	["<A-4>"] = { accept(4) },
	["<A-5>"] = { accept(5) },
	["<A-6>"] = { accept(6) },
	["<A-7>"] = { accept(7) },
	["<A-8>"] = { accept(8) },
	["<A-9>"] = { accept(9) },
}

return {
	keymap = keymaps,
	cmdline = {
		enabled = true,
		completion = {
			list = {
				selection = {
					preselect = false,
				},
			},
			menu = {
				auto_show = true,
			},
		},
		keymap = (function()
			return vim.tbl_deep_extend("force", keymaps, {
				["<CR>"] = { "fallback" },
			})
		end)(),
	},

	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		menu = {
			draw = {
				columns = {
					{ "item_idx" },
					{
						"label",
						"label_description",
						gap = 20,
					},
					{ "kind_icon" },
					{ "kind" },
					-- { 'source_name' },
				},
				components = {
					item_idx = {
						text = function(ctx)
							return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
						end,
						highlight = "BlinkCmpItemIdx", -- optional, only if you want to change its color
					},
					label = {
						text = function(ctx)
							return require("colorful-menu").blink_components_text(ctx)
						end,
						highlight = function(ctx)
							return require("colorful-menu").blink_components_highlight(ctx)
						end,
					},
				},
			},
		},
		ghost_text = { enabled = true },
		documentation = { auto_show = true },
	},

	-- Default list of enabled providers defined so that you can extend it
	-- elsewhere in your config, without redefining it, due to `opts_extend`
	-- TODO: bring in copilot
	sources = {
		default = function(_)
			local success, node = pcall(vim.treesitter.get_node)
			if success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
				return { "copilot", "path", "snippets", "buffer" }
			elseif vim.bo.filetype == "lua" then
				return { "copilot", "lsp", "path", "snippets" }
			else
				return { "copilot", "lsp", "path", "snippets", "buffer" }
			end
		end,
		providers = {
			buffer = {
				opts = {
					get_bufnrs = function()
						return vim.tbl_filter(function(bufnr)
							return vim.bo[bufnr].buftype == ""
						end, vim.api.nvim_list_bufs())
					end,
				},
			},
			copilot = {
				name = "copilot",
				module = "blink-cmp-copilot",
				score_offset = 100,
				async = true,
				transform_items = function(ctx, items)
					for _, item in ipairs(items) do
						item.kind_icon = ""
						item.kind_name = "Copilot"
					end
					return items
				end,
			},
		},
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
}
