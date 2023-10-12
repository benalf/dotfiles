local status_ok, indent_blankline = pcall(require, "ibl")
if not status_ok then
	return
end

-- vim.opt.list = true
vim.opt.listchars = {
  space = "⋅",
  extends = " ",
}

indent_blankline.setup({
  whitespace = {
    remove_blankline_trail = true,
  }
})
