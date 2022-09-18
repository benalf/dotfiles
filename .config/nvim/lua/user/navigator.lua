local status_ok, navigator = pcall(require, "navigator")
if not status_ok then
  print("navigator not installed")
  return
end

local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local servers = { "jsonls", "sumneko_lua", "rust_analyzer", "taplo"  }

lsp_installer.setup({
  ensure_installed = servers,
})

navigator.setup({
  lsp_installer = true,
  --[[ lsp_signature_help = true, ]]
  treesitter_analysis = false,
  treesitter_analysis_max_num = 10000,
  treesitter_analysis_condense = false,
  document_highlight = false,
  preview_height = 0.7,
  lsp = {
    format_on_save = false,
    phpactor = {
      init_options = {
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
