vim.g.rustaceanvim = {
	tools = {},
	server = {
		on_attach = function(client, bufnr) end,
		default_settings = {
			["rust-analyzer"] = {
				check = {
					allTargets = false,
					workspace = false,
					checkOnSave = false,
				},
				cargo = {
					allTargets = false,
				},
			},
		},
	},
	dap = {},
}
