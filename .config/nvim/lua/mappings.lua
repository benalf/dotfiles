require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>h", "<cmd>nohlsearch<CR>")
map("n", "<C-q>", "<Esc>:q!<cr>")
map("i", "<C-q>", "<Esc>:q!<cr>")
map("n", "<leader>q", "<cmd>q!<CR>")
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
map("n", "f", "<cmd>HopWord<cr>")
map("n", "gr", "<cmd>Telescope lsp_references<cr>")
map("n", "gi", "<cmd>Telescope lsp_implementations<cr>")
map("n", "gn", "<cmd>Telescope diagnostics<cr>")
map("n", "<leader>pp", "<cmd>Telescope projects<cr>")
map("n", "<C-s>", "<Esc>:w!<cr>")
map("i", "<C-s>", "<Esc>:w!<cr>")
map("n", "<leader>tt", function()
  require("base46").toggle_transparency()
end, { desc = "Toggle transparency" })
