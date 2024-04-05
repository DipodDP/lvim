local lspkind = require('lspkind')

lvim.builtin.cmp.formatting.format = lspkind.cmp_format({
  mode = 'symbol',       -- show only symbol annotations
  maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
  ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

  -- The function below will be called before any actual modifications from lspkind
  -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
  before = function(entry, vim_item)
    return vim_item
  end
})

lvim.builtin.cmp.window = {
  completion = {
    border = "rounded",
    winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:FloatBorder,Search:None",
    col_offset = -3,
    side_padding = 1,
    scrollbar = false,
    -- scrollbar = {
    --   position = 'inside',
    -- },
    scrolloff = 8,
  },
  documentation = {
    border = "rounded",
    winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,Search:None",
  },
}
vim.opt.pumblend = 10

-- lvim.builtin.cmp.formatting.source_names = {}

lvim.builtin.cmp.sources[2].entry_filter = function(entry, ctx)
  local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
  if kind == "Snippet" and ctx.prev_context.filetype == "java" then
    return false
  end

  if kind == "Text" and not ctx.prev_context.filetype == "markdown" then
    return false
  end

  return true
end

table.insert(lvim.builtin.cmp.sources, { name = "neorg" })
table.insert(lvim.builtin.cmp.sources, { name = "sqlls" })
table.insert(lvim.builtin.cmp.sources, { name = "nvim_lsp_signature_help" })

