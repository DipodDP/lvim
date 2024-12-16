local M = {}

local create_aucmd = vim.api.nvim_create_autocmd

M.config = function()
  -- local user = vim.env.USER
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      require("user.theme").telescope_theme {}
      if lvim.builtin.dap.active then
        require("user.dev_icons").define_dap_signs()
      end
      if lvim.use_icons == false and lvim.builtin.custom_web_devicons then
        require("user.dev_icons").set_icon()
      end
    end,
  })
  vim.api.nvim_clear_autocmds { pattern = "lir", group = "_filetype_settings" }
  vim.api.nvim_clear_autocmds { pattern = "*", group = "_lvim_colorscheme" }
  vim.api.nvim_create_augroup("_lvim_user", {})
  -- Autocommands
  if lvim.builtin.nonumber_unfocus then
    create_aucmd("WinEnter", { group = "_lvim_user", pattern = "*", command = "set relativenumber number cursorline" })
    create_aucmd(
      "WinLeave",
      { group = "_lvim_user", pattern = "*", command = "set norelativenumber nonumber nocursorline" }
    )
  end

  if lvim.builtin.bigfile.active == false then
    vim.cmd [[
  " disable syntax highlighting in big files
  function! DisableSyntaxTreesitter()
      if exists(':TSBufDisable')
        exec 'TSBufDisable autotag'
        exec 'TSBufDisable highlight'
      endif

      set foldmethod=manual
      syntax clear
      syntax off
      filetype off
      set noundofile
      set noswapfile
      set noloadplugins
      set lazyredraw
  endfunction

  augroup BigFileDisable
      autocmd!
      autocmd BufReadPre,FileReadPre * if getfsize(expand("%")) > 1024 * 1024 | exec DisableSyntaxTreesitter() | endif
  augroup END
    ]]
    create_aucmd("BufWinEnter", {
      group = "_lvim_user",
      pattern = "*.md",
      desc = "beautify markdown",
      callback = function()
        vim.cmd [[set syntax=markdown]]
        require("user.markdown_syn").set_syntax()
      end,
    })
  end

  if lvim.builtin.sql_integration.active then
    -- Add vim-dadbod-completion in sql files
    create_aucmd("FileType", {
      group = "_lvim_user",
      pattern = { "sql", "mysql", "plsql" },
      command = "lua require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }",
    })
  end
  create_aucmd("TextYankPost", {
    group = "_general_settings",
    pattern = "*",
    desc = "Highlight text on yank",
    callback = function()
      require("vim.highlight").on_yank { higroup = "Search", timeout = 40 }
    end,
  })
  create_aucmd("BufWritePre", {
    group = "_lvim_user",
    pattern = { "/tmp/*", "COMMIT_EDITMSG", "MERGE_MSG", "*.tmp", "*.bak" },
    callback = function()
      vim.opt_local.undofile = false
    end,
  })

  create_aucmd("TermOpen", {
    group = "_lvim_user",
    pattern = "term://*",
    command = "lua require('user.keybindings').set_terminal_keymaps()",
  })
  if lvim.builtin.metals.active then
    create_aucmd("Filetype", {
      group = "_lvim_user",
      pattern = { "scala", "sbt" },
      callback = require("user.metals").start,
    })
  end
  create_aucmd("FileType", {
    group = "_lvim_user",
    pattern = "toml",
    command = "lua require('cmp').setup.buffer { sources = { { name = 'crates' } } }",
  })

  -- local codelens_viewer = "lua require('user.codelens').show_line_sign()"
  -- -- NOTE: don't give corporate code to the devil
  -- if user and user == "abz" then
  --   if lvim.builtin.sell_your_soul_to_devil.active or lvim.builtin.tabnine.active then
  --     create_aucmd("UIEnter", {
  --       group = "_lvim_user",
  --       pattern = { "*" },
  --       callback = function()
  --         local dirpath = vim.fn.expand "%:p:h"
  --         if string.find(dirpath, user .. "/dev/src/git.") ~= nil then
  --           if lvim.builtin.sell_your_soul_to_devil.active then
  --             vim.cmd "Copilot disable"
  --           end
  --           if lvim.builtin.tabnine.active then
  --             require("cmp_tabnine.config"):setup { ignored_file_types = { "*" }, run_on_every_keystroke = false }
  --             lvim.builtin.cmp.sources = {
  --               { name = "nvim_lsp" },
  --               { name = "buffer", max_item_count = 5, keyword_length = 5 },
  --               { name = "path", max_item_count = 5 },
  --               { name = "luasnip", max_item_count = 3 },
  --               { name = "nvim_lua" },
  --               { name = "calc" },
  --               { name = "emoji" },
  --               { name = "treesitter" },
  --               { name = "latex_symbols" },
  --               { name = "crates" },
  --               { name = "orgmode" },
  --             }
  --           end
  --         end
  --       end,
  --     })
  --   end
  --   create_aucmd("CursorHold", {
  --     group = "_lvim_user",
  --     pattern = { "*.rs", "*.go", "*.ts", "*.tsx" },
  --     command = codelens_viewer,
  --   })
  -- end
end

M.make_run = function()
  create_aucmd("FileType", {
    group = "_lvim_user",
    pattern = { "c", "cpp" },
    callback = function()
      vim.keymap.set(
        "n",
        "<leader>m",
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='make ;read',count=2,direction='float'})<CR>"
      )
      vim.keymap.set(
        "n",
        "<leader>r",
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='make run;read',count=3,direction='float'})<CR>"
      )
    end,
  })
  create_aucmd("FileType", {
    group = "_lvim_user",
    pattern = "go",
    callback = function()
      vim.keymap.set(
        "n",
        "<leader>m",
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='go build -v .;read',count=2,direction='float'})<CR>"
      )
      vim.keymap.set(
        "n",
        "<leader>r",
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='go run .;read',count=3,direction='float'})<CR>"
      )
    end,
  })
  create_aucmd("FileType", {
    group = "_lvim_user",
    pattern = "python",
    callback = function()
      vim.keymap.set(
        "n",
        "<leader>r",
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='python "
        .. vim.fn.expand "%"
        .. ";read',count=2,direction='float'})<CR>"
      )
      vim.keymap.set(
        "n",
        "<leader>m",
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='echo \"compile :pepelaugh:\";read',count=2,direction='float'})<cr>"
      )
    end,
  })

  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "*.ts" },
    callback = function()
      vim.lsp.buf.format { async = true }
    end,
  })

  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = { "AlphaReady" },
    callback = function()
      vim.cmd [[
      set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
    ]]
    end,
  })

  -- vim.api.nvim_create_autocmd({"FileType"},{
  --   pattern = {
  --     "sql",
  --     "mysql",
  --     "psql"
  --   },
  --     callback = function ()
  --       require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
  --     end
  --   })

  -- vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  --   callback = function()
  --     vim.cmd "set whichwrap+=<,>,[,],h,l"
  --     vim.cmd [[set iskeyword+=-]]
  --     vim.cmd "set formatoptions-=cro"
  --   end,
  -- })

  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
      "Jaq",
      "qf",
      "help",
      "man",
      "lspinfo",
      "spectre_panel",
      "lir",
      "DressingSelect",
      "tsplayground",
      "",
    },
    callback = function()
      vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      " nnoremap <silent> <buffer> <esc> :close<CR>
      set nobuflisted
    ]]
    end,
  })

  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "Jaq" },
    callback = function()
      vim.cmd [[
      nnoremap <silent> <buffer> <m-r> :close<CR>
      " nnoremap <silent> <buffer> <m-r> <NOP>
      set nobuflisted
    ]]
    end,
  })

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufEnter" }, {
    pattern = { "*" },
    callback = function()
      local buf_ft = vim.bo.filetype
      if buf_ft == "" or buf_ft == nil then
        vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      " nnoremap <silent> <buffer> <c-j> j<CR>
      " nnoremap <silent> <buffer> <c-k> k<CR>
      set nobuflisted
    ]]
      end
    end,
  })

  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "" },
    callback = function()
      local get_project_dir = function()
        local cwd = vim.fn.getcwd()
        local project_dir = vim.split(cwd, "/")
        local project_name = project_dir[#project_dir]
        return project_name
      end
      vim.opt.titlestring = get_project_dir()
    end,
  })

  vim.cmd [[
" autocmd FileType toggleterm nnoremap <buffer> <CR> :startinsert<CR>
  autocmd BufEnter * if &filetype ==# 'toggleterm' | startinsert! | endif
]]

  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "term://*" },
    callback = function()
      vim.cmd "startinsert"
      -- vim.cmd "set cmdheight=1"
    end,
  })

  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.txt", "*.md", "*.tex" },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
  })

  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "markdown", "norg" },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
  })

  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "NeogitCommitMessage" },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
      vim.cmd "startinsert!"
    end,
  })

  vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
      vim.cmd "tabdo wincmd ="
    end,
  })

  vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
    callback = function()
      vim.cmd "quit"
    end,
  })

  vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function()
      vim.cmd "set formatoptions-=cro"
    end,
  })

  vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
      vim.highlight.on_yank { higroup = "Visual", timeout = 40 }
    end,
  })

  -- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  --   pattern = { "*.java" },
  --   callback = function()
  --     vim.lsp.codelens.refresh()
  --   end,
  -- })

  vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
      vim.cmd "hi link illuminatedWord LspReferenceText"
    end,
  })

  vim.cmd [[
  augroup terminal_setup | au!
  autocmd TermOpen * nnoremap <buffer><LeftRelease> <LeftRelease>i
  autocmd TermEnter * startinsert!
  augroup end
]]

  vim.api.nvim_create_autocmd({ "TermEnter" }, {
    pattern = { "*" },
    callback = function()
      vim.cmd "startinsert"
    end,
  })

  vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    pattern = { "*" },
    callback = function()
      vim.cmd "checktime"
    end,
  })

  vim.api.nvim_create_autocmd({ "CursorHold" }, {
    callback = function()
      local status_ok, luasnip = pcall(require, "luasnip")
      if not status_ok then
        return
      end
      if luasnip.expand_or_jumpable() then
        -- ask maintainer for option to make this silent
        -- luasnip.unlink_current()
        vim.cmd [[silent! lua require("luasnip").unlink_current()]]
      end
    end,
  })

  -- perform osc52 yank
  vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
      if vim.v.event.operator == 'y' or vim.v.event.operator == 'c' then
        require('osc52').copy_register('+')
      end
      if vim.v.event.operator == 'd' then
        vim.fn.setreg('+', vim.fn.getreg('0'))
      end
    end
  })
end

return M
