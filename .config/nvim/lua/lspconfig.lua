require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "angularls",
  "rust-analyzer",
  -- "phpactor",
  "intelephense",
  "vtsls",
}
vim.lsp.enable(servers)
-- read :h vim.lsp.config for changing options of lsp servers
