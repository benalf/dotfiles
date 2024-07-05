function prettier()
  return {
    exe = 'prettier',
    args = {
      '--config-precedence',
      'prefer-file',
      '--print-width',
      vim.bo.textwidth,
      '--stdin-filepath',
      vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
    },
    stdin = true,
  }
end
