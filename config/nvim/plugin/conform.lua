require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		sass = { "prettier" },
		scss = { "prettier" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
	},
})

vim.api.nvim_create_user_command("Format", function(args)
	require("conform").format({ bufnr = args.buf, lsp_fallback = true })
end, {
	nargs = "?", -- Subcommand is optional
	bang = true, -- Allow bang (!) for the 'disable' command
	desc = "Manage autoformat-on-save or format current buffer (disable, enable, toggle)",
	complete = function(ArgLead, CmdLine, CursorPos)
		return { "disable", "enable", "toggle" }
	end,
})
