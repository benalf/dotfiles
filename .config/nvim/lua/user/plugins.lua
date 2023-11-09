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

  use({ "hrsh7th/nvim-cmp"})
  use({ "hrsh7th/cmp-buffer" })
  use({ "hrsh7th/cmp-path"})
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "ray-x/lsp_signature.nvim" })
  --[[ use({ 'hrsh7th/cmp-nvim-lsp-signature-help' }) ]]
  use({ "hrsh7th/cmp-nvim-lua"})

  use({"L3MON4D3/LuaSnip"})
  use({"saadparwaiz1/cmp_luasnip"})

  use({ "xiyaowong/nvim-transparent"})
  use({ "sjl/gundo.vim" })
  use({ "AndrewRadev/bufferize.vim" })
  use({
      "vinnymeller/swagger-preview.nvim",
      run = "npm install -g swagger-ui-watcher",
  })

  use ({'stephpy/vim-php-cs-fixer'})
  use ({'ray-x/go.nvim'})
  use({'nvim-lua/plenary.nvim'})
  use({'mfussenegger/nvim-dap'})
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  use({ "neovim/nvim-lspconfig"})
  use({ "jose-elias-alvarez/null-ls.nvim"})
  use({ "MunifTanjim/eslint.nvim"})
  use({ "nvim-telescope/telescope.nvim"})
  use({ 'ray-x/navigator.lua',    requires = { { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' }, { 'neovim/nvim-lspconfig' } } })
  use({ "johnfrankmorgan/whitespace.nvim" })
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ':TSUpdate'
  })

  use({'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" }})

  use ({ "catppuccin/nvim", as = "catppuccin" })
  use ({ "mustache/vim-mustache-handlebars" })
  use({ "lewis6991/gitsigns.nvim"})
  use 'simrat39/rust-tools.nvim'
  use {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    config = function()
      require("fidget").setup {
        fmt = {
          fidget =
              function(fidget_name, spinner)
                if fidget_name == "phpactor" then
                  return ""
                end

                return string.format("%s %s", spinner, fidget_name)
              end,
          task = function(task_name, message, percentage)
              if task_name == "code_action" or task_name == "Resolving code actions" then
                  return false
              end
              return string.format(
                  "%s%s [%s]",
                  message,
                  percentage and string.format(" (%s%%)", percentage) or "",
                  task_name
              )
          end,
        }
      }
    end,
  }

  use ({ "onsails/lspkind.nvim" })
  use({
    "epwalsh/obsidian.nvim",
    requires = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
  })
  use{ "chentoast/marks.nvim" }
  use ({ "tpope/vim-dadbod" })
  use ({ "kristijanhusak/vim-dadbod-ui" })
  use ({ "kristijanhusak/vim-dadbod-completion" })
  use ({ "David-Kunz/gen.nvim" })
  use ({ "kristijanhusak/vim-dadbod-completion" })
  use {'nvim-telescope/telescope-ui-select.nvim' }
  use({
    "LhKipp/nvim-nu",
    run = ':TSInstall nu'
  })
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
