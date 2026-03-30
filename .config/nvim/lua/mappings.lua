require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>h", "<cmd>nohlsearch<CR>")
map("n", "<leader>gb", "<cmd>:Gitsigns blame<CR>") map("n", "<leader>gr", "<cmd>:Gitsigns reset_hunk<CR>") map("n", "<leader>gf", "<cmd>:lua require('gitsigns').blame_line({full=true})<CR>")
map("n", "<C-q>", "<Esc>:q!<cr>")
map("i", "<C-q>", "<Esc>:q!<cr>")
map("n", "<leader>q", "<cmd>q!<CR>")
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
map("n", "f", "<cmd>HopWord<cr>")
map("n", "<M-CR>", "<cmd>:lua vim.lsp.buf.code_action()<cr>")
map("n", "gr", "<cmd>Telescope lsp_references<cr>")
map("n", "gi", "<cmd>Telescope lsp_implementations<cr>")
map("n", "gd", "<cmd>Telescope lsp_definitions<cr>")
map("n", "[d", "<cmd>:lua vim.diagnostic.goto_prev()<cr>")
map("n", "]d", "<cmd>:lua vim.diagnostic.goto_next()<cr>")
map("n", "<leader>ds", "<cmd>Telescope diagnostics<cr>")
map("n", "<leader>pp", "<cmd>Telescope projects<cr>")
map("n", "<C-s>", "<Esc>:w!<cr>")
map("i", "<C-s>", "<Esc>:w!<cr>")
map("i", "<C-s>", "<Esc>:w!<cr>")
map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle {
    pos = "float",
    id = "floatTerm",
    float_opts = {
      row = 0.35,
      col = 0.05,
      width = 0.9,
      height = 0.9,
    },
  }
end, { desc = "terminal toggle floating term" })
map('n', '<A-h>', function() require('smart-splits').resize_left(5) end)
map('n', '<A-j>', function() require('smart-splits').resize_down(5) end)
map('n', '<A-k>',  function()require('smart-splits').resize_up(5) end)
map('n', '<A-l>',  function()require('smart-splits').resize_right(5) end)
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "<C-r>", '"hy:%s/<C-r>h//g<left><left>')
map("n", "<leader>tt", function()
  require("base46").toggle_transparency()
end, { desc = "Toggle transparency" })
map("n", "<leader>v", "<cmd>:GpChatNew popup<CR>")
map('n', '<leader>cc', '<cmd>ClaudeCode<CR>', { desc = 'Toggle Claude Code' })
map('n', '<leader>mt', function() require('render-markdown').toggle() end, { desc = "Toggle Markdown"})


local function format_curl()
  -- Save cursor position
  local pos = vim.api.nvim_win_get_cursor(0)
 
  -- Get all lines in the buffer
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local text = table.concat(lines, "\n")
 
  -- Write buffer to a temp file to avoid shell quoting issues with echo+shellescape
  local tmpfile = vim.fn.tempname() .. ".curl"
  local f = io.open(tmpfile, "w")
  if not f then
    vim.notify("format-curl: could not create temp file", vim.log.levels.ERROR)
    return
  end
  f:write(text)
  f:close()
 
  local script = vim.fn.expand("~/.config/nushell/tools/cf")
  local cmd = string.format("nu %s %s", vim.fn.shellescape(script), vim.fn.shellescape(tmpfile))
 
  local result = vim.fn.system(cmd)
  os.remove(tmpfile)
 
  if vim.v.shell_error ~= 0 then
    vim.notify("format-curl failed:\n" .. result, vim.log.levels.ERROR)
    return
  end
 
  -- Replace buffer contents with formatted result
  local new_lines = vim.split(result, "\n", { plain = true })
  -- Remove trailing empty line that system() sometimes adds
  if new_lines[#new_lines] == "" then
    table.remove(new_lines)
  end
 
  vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)
 
  -- Restore cursor (clamped to new buffer size)
  local line_count = vim.api.nvim_buf_line_count(0)
  pos[1] = math.min(pos[1], line_count)
  vim.api.nvim_win_set_cursor(0, pos)
 
  vim.notify("Curl formatted for nushell ✓", vim.log.levels.INFO)
end
map("n", "<leader>cf", format_curl, {
  desc = "Format curl command for nushell",
  silent = true,
})

