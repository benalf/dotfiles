local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

return packer.startup(function(use)

  use({ "phaazon/hop.nvim", branch = 'v2' })
  use({ "famiu/nvim-reload" })

  use({ "wbthomason/packer.nvim"}) -- Have packer manage itself
  use { "williamboman/mason.nvim" }
  use({ "nvim-lua/plenary.nvim"}) -- Useful lua functions used by lots of plugins
  use({ "windwp/nvim-autopairs"}) -- Autopairs, integrates with both cmp and treesitter
  use({ "numToStr/Comment.nvim"})
  use({ "JoosepAlviste/nvim-ts-context-commentstring"})
  use({ "kyazdani42/nvim-web-devicons"})
  use({ "kyazdani42/nvim-tree.lua" })
  use({ "moll/vim-bbye"})
  use({ "nvim-lualine/lualine.nvim"})
  use({ "akinsho/toggleterm.nvim"})
  use({ "ahmedkhalf/project.nvim"})
  use({ "lewis6991/impatient.nvim"})
  use({ "lukas-reineke/indent-blankline.nvim"})
  use({ "goolord/alpha-nvim"})
  use("folke/which-key.nvim")

  use({ "folke/tokyonight.nvim"})
  use("lunarvim/darkplus.nvim")
  use({ "wadackel/vim-dogrun" })

  use({ "sar/luasnip.nvim" })
  use({ "hrsh7th/nvim-cmp"})
  use({ "hrsh7th/cmp-buffer" })
  use({ "hrsh7th/cmp-path"})
  use({ "saadparwaiz1/cmp_luasnip"})
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-nvim-lua"})
  use({ "xiyaowong/nvim-transparent"})

  use({ "sjl/gundo.vim" })
  use({ "AndrewRadev/bufferize.vim" })

  use({'neovim/nvim-lspconfig'})

  -- Debugging
  use({'nvim-lua/plenary.nvim'})
  use({'mfussenegger/nvim-dap'})

  use({ "neovim/nvim-lspconfig"})
  use({ "jose-elias-alvarez/null-ls.nvim"})

  use({ "nvim-telescope/telescope.nvim"})

  use({ 'ray-x/navigator.lua',    requires = { { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' }, { 'neovim/nvim-lspconfig' } } })
  use({ "ray-x/lsp_signature.nvim" })
  use({ "johnfrankmorgan/whitespace.nvim" })
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ':TSUpdate'
  })

  use ({ "catppuccin/nvim", as = "catppuccin" })

  -- Git
  use({ "lewis6991/gitsigns.nvim"})


  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
