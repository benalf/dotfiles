local status_ok, openapi = pcall(require, "swagger-preview")
if not status_ok then
  return
end

require("swagger-preview").setup({
    port = 9999,
    host = "localhost",
})
