vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "lua-ls" })

local lsp_manager = require "lvim.lsp.manager"
lsp_manager.setup("lua_ls", {
  filetypes = { "lua" },
  -- cmd = { "/Users/chris/Library/Caches/fnm_multishells/65657_1672759387689/bin/ls_emmet", "--stdio" },
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
})

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "stylua", filetypes = { "lua" } },
}
