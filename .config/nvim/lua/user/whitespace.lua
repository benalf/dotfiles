local status_ok, whitespace = pcall(require, "whitespace-nvim")
if not status_ok then
	return
end

whitespace.setup({
    highlight = 'DiffDelete',
    ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help' },
})

vim.keymap.set('n', '<Leader>t', require('whitespace-nvim').trim)
