local status_ok, rt = pcall(require, "rust-tools")
if not status_ok then
	return
end

rt.setup({
  server = {
    on_attach = function(client, bufnr)
      require('navigator.lspclient.mapping').setup({client=client, bufnr=bufnr})
      require("navigator.dochighlight").documentHighlight(bufnr)
      require('navigator.codeAction').code_action_prompt(bufnr)
    end,
  }
})

rt.inlay_hints.enable();
