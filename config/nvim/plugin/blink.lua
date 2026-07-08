local cmp = require("blink.cmp")
cmp.build():pwait()

local opts = {
	enabled = function()
		return vim.bo.buftype ~= "prompt" and vim.b.completion ~= false
	end,
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	appearance = {
		nerd_font_variant = "normal",
	},
	completion = {
		menu = {
			draw = {
				treesitter = { "lsp", "snippets", "copilot" },
				columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } }, -- more like cmp
				components = {
					kind_icon = {
						ellipsis = false,
						text = function(ctx)
							local icon = ctx.kind_icon
							if ctx.source_id == "copilot" then
								icon = ""
							elseif ctx.source_id == "snippets" then
								icon = "󰆐"
							end
							return icon .. ctx.icon_gap
						end,
					},
					kind = {
						ellipsis = false,
						width = { fill = true },
					},
				},
			},
		},
		ghost_text = {
			enabled = true,
		},
	},
	signature = {
		enabled = true,
	},
	cmdline = {
		keymap = {
			["<cr>"] = { "select_and_accept", "fallback" },
			["<down>"] = { "select_next", "fallback" },
			["<m-d>"] = { "show_documentation", "hide_documentation" },
			["<s-tab>"] = { "select_prev", "fallback" },
			["<tab>"] = { "show", "select_next", "fallback" },
			["<up>"] = { "select_prev", "fallback" },
			["<m-n>"] = { "show", "hide" },
		},
	},
	keymap = {
		["<c-space>"] = { "show", "hide" },
		["<cr>"] = { "select_and_accept", "fallback" },
		["<down>"] = { "select_next", "fallback" },
		["<m-b>"] = { "scroll_documentation_up", "fallback" },
		["<m-d>"] = { "show_documentation", "hide_documentation" },
		["<m-f>"] = { "scroll_documentation_down", "fallback" },
		["<m-n>"] = { "show", "hide" },
		["<s-cr>"] = { "accept", "fallback" },
		["<s-tab>"] = { "snippet_backward", "select_prev", "fallback" },
		["<tab>"] = {
			function(blink)
				if blink.snippet_active() then
					return blink.accept()
				end
			end,
			"snippet_forward",
			"select_next",
			"fallback",
		},
		["<up>"] = { "select_prev", "fallback" },
	},
}

cmp.setup(opts)
