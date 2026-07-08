require("vim._core.ui2").enable({})

vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.shortmess:append("c")
vim.opt.cmdheight = 1
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.completeopt = "menu,menuone,noselect,popup"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.signcolumn = "yes"
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.hlsearch = true
vim.opt.breakindent = true
vim.opt.wrap = false

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = " ",
		},
	},
	virtual_text = true,
})

vim.pack.add({
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range("^9") },

	{
		src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
		version = vim.version.range("3"),
	},
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	{ src = "https://github.com/nvim-mini/mini.ai" },
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
	{ src = "https://github.com/mrjones2014/smart-splits.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/j-hui/fidget.nvim" },
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/binhtran432k/dracula.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
	{ src = "https://github.com/ojroques/vim-oscyank" },
})

require("dracula").setup({
	transparent = true,
	plugins = {
		telescope = true,
		blink = true,
		treesitter = true,
		gitsigns = true,
		["which-key"] = true,
	},
})

vim.cmd([[colorscheme dracula]])

vim.o.clipboard = "unnamedplus"
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
		local copy_to_unnamedplus = require("vim.ui.clipboard.osc52").copy("+")
		copy_to_unnamedplus(vim.v.event.regcontents)
		local copy_to_unnamed = require("vim.ui.clipboard.osc52").copy("*")
		copy_to_unnamed(vim.v.event.regcontents)
	end,
})
