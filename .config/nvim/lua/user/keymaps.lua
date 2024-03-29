local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

for _, mode in ipairs({[1] = "n", [2] = "v"}) do
  keymap(mode, "<C-u>", "<C-u>zz", opts)
  keymap(mode, "<C-d>", "<C-d>zz", opts)
end

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

keymap("n", "f", "<cmd>HopWord<cr>", opts)
keymap("n", "<leader>fs", ":lua require'telescope.builtin'.grep_string({search = vim.fn.expand(\"<cword>\")})<CR>", opts)
keymap("n", "<C-s>", "<Esc>:w!<cr>", opts)
keymap("i", "<C-s>", "<Esc>:w!<cr>", opts)
keymap("n", "<C-q>", "<Esc>:q!<cr>", opts)
keymap("i", "<C-q>", "<Esc>:q!<cr>", opts)


keymap('n', '<leader>u', ":lua require('undotree').toggle()", opts)

-- Insert --
keymap("i", "jk", "<ESC>", opts)
keymap("i", "<C-L>", "_", opts)
keymap("i", "<C-k>", "=", opts)
keymap("i", "<A-j>", "{", opts)
keymap("i", "<A-k>", "}", opts)
keymap("i", "<A-u>", "[", opts)
keymap("i", "<A-i>", "]", opts)
keymap("i", "<A-m>", "(", opts)
keymap("i", "<A-,>", ")", opts)
keymap("i", "<A-l>", "\"", opts)
keymap("i", "<A-;>", "'", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "<C-r>", "\"hy:%s/<C-r>h//g<left><left>", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

keymap('i', '<C-y>', "->", opts)
keymap('i', '<C-u>', "=>", opts)

