local _time = os.date "*t"

-- Neovim
-- local disabled_built_ins = {
--   "netrw",
--   "netrwPlugin",
--   "netrwSettings",
--   "netrwFileHandlers",
--   "gzip",
--   "zip",
--   "zipPlugin",
--   "tar",
--   "tarPlugin", -- 'man',
--   "getscript",
--   "getscriptPlugin",
--   "vimball",
--   "vimballPlugin",
--   "2html_plugin",
--   "logipat",
--   "rrhelper",
--   "spellfile_plugin",
--   -- 'matchit', 'matchparen', 'shada_plugin',
-- }
-- for _, _plugin in pairs(disabled_built_ins) do
--   vim.g["loaded_" .. _plugin] = 1
-- end

-- General
O.format_on_save = false
O.lint_on_save = false
O.auto_complete = true
O.auto_close_tree = 0
O.keys.leader_key = " "
-- O.treesitter.highlight.additional_vim_regex_highlighting = false

-- Themes
if _time.hour > 9 and _time.hour < 16 then
  O.colorscheme = "tokyonight"
elseif _time.hour >= 16 and _time.hour < 20 then
  -- O.colorscheme = "tokyonight"
  -- vim.g.tokyonight_style = "night"
  O.colorscheme = "doom-one"
else
  O.colorscheme = "spacegray"
end

-- Default options
O.default_options.relativenumber = true
O.default_options.wrap = true
O.default_options.timeoutlen = 200
O.default_options.foldmethod = "expr"
O.default_options.foldexpr = "nvim_treesitter#foldexpr()"
O.default_options.foldlevel = 5
-- O.default_options.shiftwidth = 4
-- O.default_options.tabstop = 8

-- LSP
-- O.lsp.document_highlight = false
-- O.lsp.diagnostics.virtual_text = false

-- Completion
O.completion.source.tabnine = { kind = " ", priority = 200, max_reslts = 6 }

-- dashboard
-- O.plugin.dashboard.footer = { "github.com/abzcoding" }

-- Treesitter
O.treesitter.ensure_installed = "maintained"
O.treesitter.matchup.enable = true
O.treesitter.ignore_install = { "haskell" }
O.treesitter.context_commentstring.enable = true
-- O.treesitter.textsubjects.enable = true
-- O.treesitter.playground.enable = true
O.treesitter.indent = { enable = false }

-- Plugins
O.plugin.dashboard.active = true
O.plugin.dap.active = true
O.plugin.galaxyline.active = true
O.plugin.telescope.defaults.path_display = { shorten = 10 }
-- O.plugin.nvimtree.hide_dotfiles = 0
O.plugin.terminal.active = true
O.plugin.zen.active = true
O.plugin.zen.window.height = 0.9
O.plugin.zen.window.width = 170
O.plugin.zen.plugins.tmux = { enabled = true }
O.plugin.zen.on_open = function(_win)
  vim.cmd [[IndentBlanklineDisable]]
end
O.plugin.zen.on_close = function()
  vim.cmd [[IndentBlanklineEnable]]
end

-- Language Specific

-- python
O.lang.python.formatter.exe = "black"
O.lang.python.formatter.args = { "-l", "120", "-" }
-- O.lang.python.isort = true
-- O.lang.python.linters = { "flake8", "pylint" }
O.lang.python.diagnostics.virtual_text = false
O.lang.python.analysis.type_checking = "basic"

-- javascript
O.lang.tsserver.linter = nil

-- rust
O.lang.rust.rust_tools.active = true

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
O.user_autocommands = {
  { "Filetype", "rust", "nnoremap <leader>lm <Cmd>RustExpandMacro<CR>" },
  { "Filetype", "rust", "nnoremap <leader>lH <Cmd>RustToggleInlayHints<CR>" },
  { "Filetype", "rust", "nnoremap <leader>le <Cmd>RustRunnables<CR>" },
  { "Filetype", "rust", "nnoremap <leader>lh <Cmd>RustHoverActions<CR>" },
}

-- Additional Plugins
O.user_plugins = {
  {
    "rcarriga/vim-ultest",
    config = function()
      vim.g.ultest_use_pty = 1
    end,
    requires = { "vim-test/vim-test" },
    run = ":UpdateRemotePlugins",
    cmd = "Ultest",
  },
  {
    "folke/tokyonight.nvim",
    config = function()
      vim.g.tokyonight_hide_inactive_statusline = true
    end,
  },
  {
    "NTBBloodbath/doom-one.nvim",
    config = function()
      vim.g.doom_one_italic_comments = true
      -- vim.g.doom_one_terminal_colors = true
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").on_attach()
    end,
    event = "InsertEnter",
  },
  {
    "ethanholz/nvim-lastplace",
    config = function()
      require("nvim-lastplace").setup {
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
          "gitcommit",
          "gitrebase",
          "svn",
          "hgcommit",
        },
        lastplace_open_folds = true,
      }
    end,
    event = "BufWinEnter",
  },
  {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end,
    event = "BufRead",
  },
  {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end,
    cmd = "Trouble",
    -- event = "BufRead",
  },
  {
    "ggandor/lightspeed.nvim",
    event = "BufRead",
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    -- event = "BufRead",
  },
  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
    -- event = "BufRead",
  },
  {
    "nvim-telescope/telescope-project.nvim",
    event = "BufWinEnter",
    setup = function()
      vim.cmd [[packadd telescope.nvim]]
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    setup = function()
      vim.g.indentLine_enabled = 1
      vim.g.indent_blankline_char = "▏"
      vim.g.indent_blankline_filetype_exclude = {
        "help",
        "terminal",
        "dashboard",
      }
      vim.g.indent_blankline_buftype_exclude = { "terminal" }
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_first_indent_level = true
    end,
  },
  { "tzachar/compe-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-compe", event = "InsertEnter" },
  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
        dimming = {
          alpha = 0.25, -- amount of dimming
          -- we try to get the foreground from the highlight groups or fallback color
          color = { "Normal", "#ffffff" },
        },
        context = 15, -- amount of lines we will try to show around the current line
        -- treesitter is used to automatically expand the visible text,
        -- but you can further control the types of nodes that should always be fully expanded
        expand = {
          "function",
          "method",
          "table",
          "if_statement",
        },
        exclude = {}, -- exclude these filetypes
      }
    end,
    cmd = "ZenMode",
    -- event = "BufRead",
  },
  { "kevinhwang91/nvim-bqf", event = "BufRead" },
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("dapui").setup()
    end,
    requires = { "mfussenegger/nvim-dap" },
    ft = "python",
  },
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  },
  -- 	{
  -- 		"andweeb/presence.nvim",
  -- 		config = function()
  -- 			require("presence"):setup({
  -- 				-- General options
  -- 				auto_update = true,
  -- 				neovim_image_text = "LunarVim to the moon",
  -- 				main_image = "file",
  -- 				client_id = "793271441293967371",
  -- 				log_level = nil,
  -- 				debounce_timeout = 10,
  -- 				enable_line_number = true, -- Displays the current line number instead of the current project
  --
  -- 				-- Rich Presence text options
  -- 				editing_text = "Editing %s", -- string rendered when an editable file is loaded in the buffer
  -- 				file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer
  -- 				git_commit_text = "Committing changes", -- string rendered when commiting changes in git
  -- 				plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins
  -- 				reading_text = "Reading %s", -- string rendered when a read-only file is loaded in the buffer
  -- 				workspace_text = "Working on %s", -- Workspace format string (either string or function(git_project_name: string|nil, buffer: string): string)
  -- 				line_number_text = "Line %s out of %s", -- Line number string (for when enable_line_number is set to true)
  -- 			})
  -- 		end,
  -- 	},
  -- {'pwntester/octo.nvim', config=function()
  --   require"octo".setup()
  -- end
  -- },
  -- {
  --   "simrat39/rust-tools.nvim",
  --   config = function ()
  --     require('rust-tools').setup()
  --   end,
  --   ft="rust"
  -- },
  -- {
  --   "folke/zen-mode.nvim",
  --   cmd = "ZenMode",
  --   config = function()
  --     require("zen-mode").setup {
  --       window = {
  --         backdrop = 1,
  --         height = 0.9, -- height of the Zen window
  --         width = 170,
  --         options = {
  --           signcolumn = "no", -- disable signcolumn
  --           number = false, -- disable number column
  --           relativenumber = false, -- disable relative numbers
  --           -- cursorline = false, -- disable cursorline
  --           -- cursorcolumn = false, -- disable cursor column
  --           -- foldcolumn = "0", -- disable fold column
  --           -- list = false, -- disable whitespace characters
  --         },
  --       },
  --       plugins = {
  --         gitsigns = { enabled = false }, -- disables git signs
  --         tmux = { enabled = false },
  --         twilight = { enabled = true },
  --       },
  --       on_open = function(_win)
  --         vim.cmd [[IndentBlanklineDisable]]
  --       end,
  --       on_close = function()
  --         vim.cmd [[IndentBlanklineEnable]]
  --       end,
  --     }
  --   end,
  -- },
  -- {
  -- 	"folke/persistence.nvim",
  -- 	event = "VimEnter",
  -- 	module = "persistence",
  -- 	config = function()
  -- 		require("persistence").setup({
  -- 			dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
  -- 			options = { "buffers", "curdir", "tabpages", "winsize" },
  -- 		})
  -- 	end,
  -- },
}

-- Additional Leader bindings for WhichKey
O.user_which_key = {
  o = { "<cmd>SymbolsOutline<cr>", "Symbol Outline" },
  P = { "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Projects" },
  t = {
    name = "+Trouble",
    r = { "<cmd>Trouble lsp_references<cr>", "References" },
    f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
    d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticss" },
    q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
    l = { "<cmd>Trouble loclist<cr>", "LocationList" },
    w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticss" },
  },
  T = {
    name = "+Tests",
    r = { "<cmd>Ultest<cr>", "Run" },
    s = { "<cmd>UltestSummary<cr>", "Summary" },
    n = { "<cmd>UltestNearest<cr>", "Nearest" },
    o = { "<cmd>UltestOutput<cr>", "Output" },
  },
  -- z = {"<cmd>ZenMode<cr>", "Zen"},
  -- Q = {
  -- 	name = "+Quit",
  -- 	s = { "<cmd>lua require('persistence').load()<cr>", "Restore for current dir" },
  -- 	l = { "<cmd>lua require('persistence').load(last=true)<cr>", "Restore last session" },
  -- 	d = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
  -- },
}
O.user_which_key["gd"] = { "<cmd>DiffviewOpen HEAD~1<cr>", "Diff" }
O.user_which_key["dU"] = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle UI" }
O.user_which_key["de"] = { "<cmd>lua require('dapui').eval()<cr>", "Eval" }
