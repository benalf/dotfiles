require'lspconfig'.gdscript.setup{
  on_attach = function(client, bufnr)
    require('navigator.lspclient.mapping').setup({client=client, bufnr=bufnr})
    require("navigator.dochighlight").documentHighlight(bufnr)
  end,
  filetypes = { "gd", "gdscript", "gdscript3" },
}

local dap = require('dap')
dap.adapters.godot = {
  type = "server",
  host = '127.0.0.1',
  port = 6006,
}

dap.configurations.gdscript = {
  {
    type = "godot",
    request = "launch",
    name = "Launch scene",
    project = "${workspaceFolder}",
    launch_scene = true,
  }
}

local group = vim.api.nvim_create_augroup("godot", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gdscript" },
  callback = function()
    vim.cmd([[
      setlocal foldmethod=expr
      setlocal tabstop=4
      setlocal shiftwidth=4
      setlocal indentexpr=
      setlocal noexpandtab
    ]])

  end,
  group = group
})

