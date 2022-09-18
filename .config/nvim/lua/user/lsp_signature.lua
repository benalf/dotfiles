local status_ok, lsp_signature = pcall(require, "lsp_signature")
if not status_ok then
  print("lsp_signature not installed")
  return
end

lsp_signature.setup({})
