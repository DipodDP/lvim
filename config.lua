-- Neovim
-- ========================================= lvim.leader = " "
-- lvim.colorscheme = "onedark" -- set to a custom theme
-- lvim.colorscheme = "darkplus" -- set to a custom theme
-- lvim.colorscheme = "catppuccin-mocha" -- set to a custom theme
lvim.colorscheme = "primer_dark"
-- lvim.transparent_window = true -- enable/disable transparency
lvim.builtin.time_based_themes = false -- set false to use your own configured theme
lvim.debug = true
vim.lsp.set_log_level "error"
lvim.log.level = "warn"
require("user.neovim").config()
lvim.lsp.code_lens_refresh = true
-- lvim.lsp.installer.setup.automatic_installation = false

-- Customization
-- =========================================
lvim.builtin.sell_your_soul_to_devil = { active = false, prada = false, openai = false } -- if you want microsoft to abuse your soul
lvim.builtin.lastplace = { active = true }                                               -- change to false if you are jumping to future
lvim.builtin.tabnine = { active = true }                                                 -- change to false if you don't like tabnine
lvim.builtin.persistence = { active = true }                                             -- change to false if you don't want persistence
lvim.builtin.presence = { active = false }                                               -- change to true if you want discord presence
lvim.builtin.orgmode = { active = false }                                                -- change to true if you want orgmode.nvim
lvim.builtin.dap.active = false                                                          -- change this to enable/disable debugging
lvim.builtin.fancy_statusline = { active = true }                                        -- enable/disable fancy statusline
lvim.builtin.fancy_wild_menu = { active = false }                                        -- enable/disable cmp-cmdline
lvim.builtin.fancy_diff = { active = false }                                             -- enable/disable fancier git diff
lvim.builtin.lua_dev = { active = true }                                                 -- change this to enable/disable folke/lua_dev
lvim.builtin.test_runner = { active = true, runner = "ultest" }                          -- change this to enable/disable ultest or neotest
lvim.builtin.cheat = { active = false }                                                  -- enable/disable cheat.sh integration
lvim.builtin.sql_integration = { active = false }                                        -- use sql integration
lvim.builtin.smooth_scroll =
""                                                                                       -- for smoth scrolling, can be "cinnamon", "neoscroll" or ""
lvim.builtin.neoclip = { active = true, enable_persistent_history = false }
lvim.builtin.nonumber_unfocus = false                                                    -- diffrentiate between focused and non focused windows
lvim.builtin.custom_web_devicons = false                                                 -- install https://github.com/Nguyen-Hoang-Nam/mini-file-icons
lvim.builtin.harpoon = { active = true }                                                 -- use the harpoon plugin
lvim.builtin.remote_dev = { active = false }                                             -- enable/disable remote development
lvim.builtin.cursorline = { active = false }                                             -- use a bit fancier cursorline
-- lvim.builtin.motion_provider = "hop" -- change this to use different motion providers ( hop or leap or flash)
lvim.builtin.hlslens = { active = false }                                                -- enable/disable hlslens
lvim.builtin.csv_support = false                                                         -- enable/disable csv support
lvim.builtin.sidebar = { active = false }                                                -- enable/disable sidebar
lvim.builtin.task_runner =
""                                                                                       -- change this to use different task runners ( "async_tasks" or "overseer" or "")
lvim.builtin.winbar_provider =
"filename"                                                                               -- can be "filename" or "treesitter" or "navic" or ""
lvim.builtin.metals = {
  active = false,                                                                        -- enable/disable nvim-metals for scala development
  fallbackScalaVersion = "3.2.0-RC3",
  serverVersion = "1.0.1",
  bloopVersion = "1.5.11",
}
lvim.builtin.collaborative_editing = { active = false } -- enable/disable collaborative editing
lvim.builtin.file_browser = { active = false }          -- enable/disable telescope file browser
lvim.builtin.sniprun = { active = false }               -- enable/disable sniprun
lvim.builtin.tag_provider =
"symbols-outline"                                       -- change this to use different tag providers ( symbols-outline or vista or outline)
lvim.builtin.global_statusline = false                  -- set true to use global statusline
lvim.builtin.dressing = { active = true }               -- enable to override vim.ui.input and vim.ui.select with telescope
lvim.builtin.refactoring = { active = false }           -- enable to use refactoring.nvim code_actions
lvim.builtin.tmux_lualine = false                       -- use vim-tpipeline to integrate lualine and tmux
lvim.builtin.lsp_lines = false                          -- enable/disable lsp_lines to display lsp virtual text below instead of behind
lvim.builtin.legendary = { active = false }             -- enable/disable legendary plugin ( ctrl-p command )
lvim.builtin.tree_provider = "nvimtree"                 -- can be "neo-tree" or "nvimtree" or ""
-- lvim.builtin.lir.active = false
-- lvim.builtin.breadcrumbs.active = false
-- lvim.builtin.illuminate.active = false
lvim.builtin.noice = { active = false }                                      -- enables noice.nvim and inc-rename.nvim
lvim.builtin.go_programming = { active = false }                             -- gopher.nvim + nvim-dap-go
lvim.builtin.python_programming = { active = false }                         -- swenv.nvim + nvim-dap-python + requirements.txt.vim
lvim.builtin.web_programming = { active = false, extra = "typescript.nvim" } -- (typescript.nvim or typescript-tools.nvim) + package-info.nvim
lvim.builtin.rust_programming = { active = false }                           -- rustaceanvim + crates.nvim
lvim.builtin.cpp_programming = { active = false }                            -- clangd_extensions.nvim + make-tools.nvim
lvim.builtin.cmp.cmdline.enable = false
lvim.builtin.borderless_cmp = false
lvim.builtin.symbols_usage = { active = false } -- enable/disable symbols-usage.nvim
lvim.builtin.colored_args = true -- if true then sets up hlargs.nvim
lvim.builtin.bigfile.active = true
lvim.builtin.indentlines.active = true
lvim.builtin.indentlines.mine = false -- NOTE: using v3 till fixed upstream in lunarvim
lvim.builtin.mind = { active = false, root_path = "~/.mind" } -- enable/disable mind.nvim

-- Custom User Config
-- =========================================
-- local user = vim.env.USER
-- if user and user == "abz" then
--   lvim.reload_config_on_save = true
--   require("user.custom_user").config()
-- end

-- Additional Actions Based on Custom User Config
-- =========================================
-- if lvim.builtin.winbar_provider == "navic" then
--   vim.opt.showtabline = 1
--   lvim.keys.normal_mode["<tab>"] =
--   "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal'})<cr>"
--   lvim.builtin.bufferline.active = false
--   lvim.builtin.breadcrumbs.active = true
-- end
if lvim.builtin.breadcrumbs.active and lvim.builtin.noice.active then
  table.insert(lvim.builtin.breadcrumbs.winbar_filetype_exclude, "vim")
end
lvim.builtin.nvimtree.active = lvim.builtin.tree_provider == "nvimtree"
lvim.builtin.latex = {
  view_method = "skim",                                                       -- change to zathura if you are on linux
  preview_exec = "/Applications/Skim.app/Contents/SharedSupport/displayline", -- change this to zathura as well
  rtl_support = true,                                                         -- if you want to use xelatex, it's a bit slower but works very well for RTL langs
  active = false,                                                             -- set to true to enable
}
if lvim.builtin.cursorline.active then
  lvim.lsp.document_highlight = false
end

-- Override Lunarvim defaults
-- =========================================
require("user.builtin").config()

-- StatusLine
-- =========================================
if lvim.builtin.fancy_statusline.active then
  require("user.lualine").config()
end

-- Debugging
-- =========================================
if lvim.builtin.dap.active then
  require("user.dap").config()
end

-- Language Specific
-- =========================================
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, {
--   "clangd",
--   "dockerls",
--   "gopls",
--   "golangci_lint_ls",
--   "jdtls",
--   "pyright",
--   "rust_analyzer",
--   "taplo",
--   "texlab",
--   -- "tsserver",
--   "yamlls",
-- })
reload "user.dap"
reload "user.chatgpt"
-- reload "rest"
-- reload "metals"
-- reload "image"
-- reload "neorg"
reload "plugins"
reload "options"
reload "keymaps"
reload "user.lsp"
reload "user.smoothie"
reload "autocommands"
reload "user.webdev-icons"
reload "user.cybu"
reload "user.surround"
reload "user.neotest"
reload "todo-comments"
reload "jaq"
reload "fidget"
reload "git"
reload "zen-mode"
reload "user.inlay-hints"
-- reload "telescope"
reload "bqf"
reload "user.dial"
reload "user.numb"
reload "treesitter"
reload "user.colorizer"
reload "user.lualine"
reload "user.tabnine"
reload "neoscroll"
reload "whichkey"
reload "user.cmp"
reload "nvimtree"
reload "user.nostr"
reload "user.astro-tools"
reload "user.matchup"
reload "user.dotenv"


vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder)
vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder)
vim.keymap.set('n', '<space>wl', function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end)
vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition)
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename)
vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set('n', '<space>f', function()
  vim.lsp.buf.format { async = true }
end)

require 'lspconfig'.csharp_ls.setup {}

require("swagger-preview").setup({
  -- The port to run the preview server on
  port = 8000,
  -- The host to run the preview server on
  host = "localhost",
})
-- require("user.null_ls").config()

-- Additional Plugins
-- =========================================
-- require("user.plugins").config()
reload "user.nvimtree"
reload "user.lualine"
reload "user.modicator"
reload "user.lsp"
reload "user.smoothie"
-- reload "user.harpoon"
-- reload "user.bookmark"
-- reload "user.bookmarks"
-- reload "user.todo-comments"
-- reload "user.jaq"
-- reload "user.fidget"
-- reload "user.lab"
-- reload "user.git"
-- reload "user.zen-mode"
-- reload "user.inlay-hints"
-- reload "user.telescope"
reload "user.bqf"
-- reload "user.dial"
-- reload "user.numb"
-- reload "user.treesitter"
-- reload "user.neogit"
-- reload "user.colorizer"
-- reload "user.neoscroll"
-- reload "user.dotenv"
-- -- reload "user.tabnine"
-- -- reload "user.copilot"
-- -- reload "user.chatgpt"
-- -- reload "user.neoai"
-- reload "user.whichkey"
-- reload "user.cmp"
-- reload "nostr"
-- reload "user.astro-tools"
-- reload "user.matchup"
reload "user.betterescape"
reload "user.yanky"
-- reload "user.rest"
-- reload "user.metals"
-- reload "user.image"
-- reload "user.neorg"

-- Autocommands
-- =========================================
-- require("user.autocommands").config()
-- reload "autocommands"

-- -- Additional Keybindings
-- -- =========================================
-- require("user.keybindings").config()
-- reload "keymaps"

-- require("transparent").setup({ -- Optional, you don't have to run setup.
--   groups = {                   -- table: default groups
--     'lualine_c_replace', 'lualine_c_visual', 'lualine_c_insert', 'lualine_c_normal',
--     'Float', 'NormalFloat',
--     'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
--     'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
--     'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
--     'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
--     'EndOfBuffer',
--   },
--   extra_groups = {},   -- table: additional groups that should be cleared
--   exclude_groups = {}, -- table: groups you don't want to clear
-- })

-- Default options:
require("gruvbox").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "",  -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {
    CursorLine = {
      blend = vim.o.pumblend,
      bg = "NONE",
    },
    CursorLineNr = {
      blend = vim.o.pumblend,
      bg = "NONE",
    },
    lualine_c_replace = {
      -- guibg = "NONE",
    },
    lualine_c_visual = {
      -- guibg = "NONE",
    },
    lualine_c_normal = {
      -- guibg = "NONE",
    },
    lualine_c_insert = {
      -- guibg = "NONE",
    },
    Pmenu = {
      blend = 0,
      bg = "NONE"
    }
  },
  dim_inactive = false,
  transparent_mode = true,
})
