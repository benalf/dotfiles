local nvlsp = require "nvchad.configs.lspconfig"

local on_attach = function(client, bufnr)
  nvlsp.on_attach(client, bufnr)
  vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { buffer = bufnr })
  vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { buffer = bufnr })
  vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { buffer = bufnr })
end

local servers = {
  html = {},
  cssls = {},
  angularls = {},
  ["ruby-lsp"] = {
    filetypes = { "ruby" },
    root_markers = { "Gemfile", ".git" },
    init_options = {
      formatter = 'standard',
      linters = { 'standard' },
      addonSettings = {
        ["Ruby LSP Rails"] = {
          enablePendingMigrationsPrompt = false,
        },
      },
    },
  },
  ["rust-analyzer"] = {},
  intelephense = {},
  vtsls = {},
  ruff = {},
  basedpyright = {},
}

vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    }
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

for name, opts in pairs(servers) do
  opts.on_attach = on_attach
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
