local status_ok, yanky = pcall(require, "yanky")
if not status_ok then
	return
end
yanky.setup {
  preserve_cursor_position = {
    enabled = true,
  },
}

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
keymap({ "n", "x" }, "y", "<Plug>(YankyYank)")
keymap({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
keymap({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", opts)
keymap({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", opts)
keymap("n", "<c-n>", "<Plug>(YankyCycleForward)", opts)
keymap("n", "<c-p>", "<Plug>(YankyCycleBackward)", opts)
