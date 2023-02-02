local status_ok, navigator = pcall(require, "navigator")
if not status_ok then
  print("navigator not installed")
  return
end

local util = require 'lspconfig.util'


navigator.setup({
  default_mapping = false,
  keymaps = {
    { key = 'gr', func = require('navigator.reference').async_ref, desc = 'async_ref' },
    { mode = 'i', key = '<M-k>', func = vim.lsp.signature_help, desc = 'signature_help' },
    { key = '<c-k>', func = vim.lsp.buf.signature_help, desc = 'signature_help' },
    { key = '<c-]>', func = require('navigator.definition').definition, desc = 'definition' },
    { key = 'gd', func = require('navigator.definition').definition, desc = 'definition' },
    { key = 'gD', func = vim.lsp.buf.declaration, desc = 'declaration' },
    { key = 'gp', func = require('navigator.definition').definition_preview, desc = 'definition_preview' },
    { key = '<Leader>gt', func = require('navigator.treesitter').buf_ts, desc = 'buf_ts' },
    { key = '<Leader>gT', func = require('navigator.treesitter').bufs_ts, desc = 'bufs_ts' },
    { key = '<Leader>ct', func = require('navigator.ctags').ctags, desc = 'ctags' },
    { key = 'K', func = vim.lsp.buf.hover, desc = 'hover' },
    { key = '<Space>ca', mode = 'n', func = require('navigator.codeAction').code_action, desc = 'code_action' },
    {
      key = '<Space>ca',
      mode = 'v',
      func = require('navigator.codeAction').range_code_action,
      desc = 'range_code_action',
    },
    { key = '<Space>rn', func = require('navigator.rename').rename, desc = 'rename' },
    { key = '<Leader>gi', func = vim.lsp.buf.incoming_calls, desc = 'incoming_calls' },
    { key = '<Leader>go', func = vim.lsp.buf.outgoing_calls, desc = 'outgoing_calls' },
    { key = 'gi', func = vim.lsp.buf.implementation, desc = 'implementation' },
    { key = '<Space>D', func = vim.lsp.buf.type_definition, desc = 'type_definition' },
    { key = 'gL', func = require('navigator.diagnostics').show_diagnostics, desc = 'show_diagnostics' },
    { key = 'gG', func = require('navigator.diagnostics').show_buf_diagnostics, desc = 'show_buf_diagnostics' },
    { key = '<Leader>dt', func = require('navigator.diagnostics').toggle_diagnostics, desc = 'toggle_diagnostics' },
    { key = ']d', func = vim.diagnostic.goto_next, desc = 'next diagnostics' },
    { key = '[d', func = vim.diagnostic.goto_prev, desc = 'prev diagnostics' },
    { key = ']O', func = vim.diagnostic.set_loclist, desc = 'diagnostics set loclist' },
    { key = ']r', func = require('navigator.treesitter').goto_next_usage, desc = 'goto_next_usage' },
    { key = '[r', func = require('navigator.treesitter').goto_previous_usage, desc = 'goto_previous_usage' },
    { key = '<C-LeftMouse>', func = vim.lsp.buf.definition, desc = 'definition' },
    { key = 'g<LeftMouse>', func = vim.lsp.buf.implementation, desc = 'implementation' },
    { key = '<Leader>k', func = require('navigator.dochighlight').hi_symbol, desc = 'hi_symbol' },
    { key = '<Space>wa', func = require('navigator.workspace').add_workspace_folder, desc = 'add_workspace_folder' },
    {
      key = '<Space>wr',
      func = require('navigator.workspace').remove_workspace_folder,
      desc = 'remove_workspace_folder',
    },
    { key = '<Space>ff', func = vim.lsp.buf.format, mode = 'n', desc = 'format' },
    { key = '<Space>ff', func = vim.lsp.buf.range_formatting, mode = 'v', desc = 'range format' },
    {
      key = '<Space>gm',
      func = require('navigator.formatting').range_format,
      mode = 'n',
      desc = 'range format operator e.g gmip',
    },
    { key = '<Space>wl', func = require('navigator.workspace').list_workspace_folders, desc = 'list_workspace_folders' },
    { key = '<Space>la', mode = 'n', func = require('navigator.codelens').run_action, desc = 'run code lens action' },
  },
  mason = true,
  lsp_signature_help = true,
  lsp = {
    disable_lsp = { 'denols' },
    diagnostic = {
      update_in_insert = true,
      underline = false,
    },
    diagnostic_update_in_insert = true,
    format_on_save = false,
    disply_diagnostic_qf = false,
    servers = {"gdscript"},
    intelephense = {
      flags = {
      },
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false;
      end,
    },
    phpactor = {
      flags = {
        allow_incremental_sync = false,
      },
      init_options = {
        ["language_server_php_cs_fixer.enabled"] = true,
        ["language_server_phpstan.enabled"] = true,
        ["completion_worse.completor.doctrine_annotation.enabled"] = false,
        ["completion_worse.completor.imported_names.enabled"] = false,
        ["completion_worse.completor.worse_parameter.enabled"] = false,
        ["completion_worse.completor.named_parameter.enabled"] = false,
        ["completion_worse.completor.constructor.enabled"] = false,
        ["completion_worse.completor.class_member.enabled"] = false,
        ["completion_worse.completor.scf_class.enabled"] = false,
        ["completion_worse.completor.local_variable.enabled"] = false,
        ["completion_worse.completor.declared_function.enabled"] = false,
        ["completion_worse.completor.declared_constant.enabled"] = false,
        ["completion_worse.completor.declared_class.enabled"] = false,
        ["completion_worse.completor.expression_name_search.enabled"] = false,
        ["completion_worse.completor.use.enabled"] = false,
        ["completion_worse.completor.class_like.enabled"] = false,
        ["completion_worse.completor.type.enabled"] = false,
        ["completion_worse.completor.keyword.enabled"] = false,
        ["completion_worse.completor.docblock.enabled"] = false,
        ["completion_worse.completor.constant.enabled"] = false
      }
    }
  }
})
