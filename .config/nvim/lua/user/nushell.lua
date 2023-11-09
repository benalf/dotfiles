require'nu'.setup{
      use_lsp_features = true, -- requires https://github.com/jose-elias-alvarez/null-ls.nvim
    all_cmd_names = [[nu -c 'help commands | get name | str join "\n"']]
}

