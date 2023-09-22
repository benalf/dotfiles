local api = vim.api
local map = vim.keymap.set

local metals_config = require("metals").bare_config()

map("n", "<leader>re", function()
  require("metals")require"telescope".extensions.metals.commands()
end)

metals_config.settings = {
  showImplicitArguments = true,
  showInferredType = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}

metals_config.on_attach = function(client, bufnr)
  require('navigator.lspclient.mapping').setup({client=client, bufnr=bufnr})
  require("navigator.dochighlight").documentHighlight(bufnr)
  require('navigator.codeAction').code_action_prompt(bufnr)
end

metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()


local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
