require "nvchad.autocmds"

local function mod_hl(hl_name, opts)
  local is_ok, hl_def = pcall(vim.api.nvim_get_hl, hl_name, true)
  if is_ok then
    for k,v in pairs(opts) do hl_def[k] = v end
    vim.api.nvim_set_hl(0, hl_name, hl_def)
  else
    vim.api.nvim_set_hl(0, hl_name, opts)
  end
end

vim.api.nvim_create_autocmd({"VimEnter", "ColorScheme"}, {
  group = vim.api.nvim_create_augroup('Color', {}),
  pattern = "*",
  callback = function ()
    mod_hl("NotificationInfo", {  bold=true, italic=true })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "dbout",
  callback = function()
    vim.opt_local.foldenable = false
  end,
})


