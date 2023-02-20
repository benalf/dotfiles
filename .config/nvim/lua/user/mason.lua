local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

mason.setup({
  --[[ config = function () ]]
  --[[   require("mason-lspconfig").setup_handlers({ ]]
  --[[     ["rust_analyzer"] = function() ]]
  --[[       require("lspconfig").pylsp.setup({ ]]
  --[[         on_attach = function(client, bufnr) ]]
  --[[           print("hellllloo") ]]
  --[[           require("navigator.lspclient.mapping").setup({ client = client, bufnr = bufnr }) -- setup navigator keymaps here, ]]
  --[[           require("navigator.dochighlight").documentHighlight(bufnr) ]]
  --[[           require("navigator.codeAction").code_action_prompt(bufnr) ]]
  --[[         end, ]]
  --[[       }) ]]
  --[[     end, ]]
  --[[   }) ]]
  --[[ end ]]
})
