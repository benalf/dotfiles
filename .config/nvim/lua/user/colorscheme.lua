vim.cmd [[
try
  colorscheme tokyonight-moon
  set background=dark
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
