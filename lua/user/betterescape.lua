local status_ok, better_escape = pcall(require, "better_escape")
if not status_ok then
  return
end

better_escape.setup {
  -- `k` would be the second key of a mapping
  k = function()
    vim.api.nvim_input "<esc>"
    local current_line = vim.api.nvim_get_current_line()
    if current_line:match "^%s+j$" then
      vim.schedule(function()
        vim.api.nvim_set_current_line ""
      end)
    end
  end,
  timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
  clear_empty_lines = false, -- clear line after escaping if there is only whitespace
}
