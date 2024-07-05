local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local util = require('lspconfig.util')
mason.setup()

require('mason-lspconfig').setup({
  handlers = {
    ['angularls'] = function()
      require('lspconfig').angularls.setup({
        single_file_support = false,
        root_dir = util.root_pattern('angular.json' , 'nx.json'),
        on_attach = function(client, bufnr)
          require('navigator.lspclient.mapping').setup({client=client, bufnr=bufnr})
          require("navigator.dochighlight").documentHighlight(bufnr)
          require('navigator.codeAction').code_action_prompt(bufnr)
        end
      })
    end,
    ['tsserver'] = function()
      require('lspconfig').tsserver.setup({
        on_attach = function(client, bufnr)
          require('navigator.lspclient.mapping').setup({client=client, bufnr=bufnr})
          require("navigator.dochighlight").documentHighlight(bufnr)
          require('navigator.codeAction').code_action_prompt(bufnr)
        end
      })
    end
  }
})
