vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt.cmdheight=1

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "shfmt", filetypes = { "sh", "zsh", "bash" } },
}

vim.filetype.add {
  extension = {
    zsh = "zsh",
  },
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "bashls" })

local lsp_manager = require "lvim.lsp.manager"
lsp_manager.setup("bashls", {
  filetypes = { "sh", "zsh" },
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
})

lsp_manager.setup("lua_ls", {
  filetypes = { "lua" },
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
})
