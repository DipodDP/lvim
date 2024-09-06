local lsp_manager = require "lvim.lsp.manager"
lsp_manager.setup("sqlls", {
  filetypes = { "sql", "SQL" },
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
})

local json = [[
{
  "language": "postgresql",
  "tabWidth": 2,
  "keywordCase": "upper",
  "linesBetweenQueries": 2
}
]]

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "sql-formatter",
    filetypes = { "sql" },
    extra_args = { "-c", json }, -- specify your SQL dialect here
  },
}
