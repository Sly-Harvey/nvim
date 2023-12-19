require("core.options")
require("core.lazy")
require("core.keymaps")

local util = require("util")

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
augroup('bufcheck', { clear = true })
augroup("terminal_settings", { clear = true })

vim.cmd("colorscheme " .. util.colorscheme)
if util.colorscheme == "everforest" then
  util.ColorMyPencils(util.colorscheme)
end

-- set additional transparent ui elements for specific colorschemes
autocmd({ "ColorScheme" }, {
  pattern = { "everforest" },
  callback = function()
    util.ColorMyPencils(util.colorscheme)
  end
})

autocmd("BufReadPre", {
  desc = "Disable certain functionality on very large files",
  group = augroup("large_buf", { clear = true }),
  callback = function(args)
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    vim.b[args.buf].large_buf = (ok and stats and stats.size > vim.g.max_file.size)
      or vim.api.nvim_buf_line_count(args.buf) > vim.g.max_file.lines
  end,
})

-- disable semantic tokens
autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
});

-- auto update the highlight style on colorscheme change
autocmd({ "ColorScheme" }, {
  pattern = { "*" },
  callback = function(ev)
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
  end
})

autocmd("BufEnter", {
  pattern = "term://*",
  group = "terminal_settings",
  desc = "Start terminal in insert mode",
  callback = function() vim.cmd("startinsert") end,
})

-- Return to last edit position when opening files
autocmd('BufReadPost', {
  group    = 'bufcheck',
  pattern  = '*',
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.fn.setpos('.', vim.fn.getpos("'\""))
      -- vim.cmd('normal zz') -- how do I center the buffer in a sane way??
      vim.cmd('silent! foldopen')
    end
  end
})

-- Highlight when yanking
autocmd('TextYankPost', {
  group = augroup('HighlightYank', {}),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40,
    })
  end,
})

-- resize splits if window got resized
autocmd({ "VimResized" }, {
  group = augroup('resize_splits', { clear = true }),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- close with q
autocmd("FileType", {
  group = augroup("close-with-q", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(data)
    vim.bo[data.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = data.buf, silent = true })
  end,
})

-- wrap and check for spell in text filetypes
autocmd("FileType", {
  group = augroup("wrap_spell", { clear = true }),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

if vim.fn.has("toggleterm") then
  if util.auto_open_toggleterm == true then
    -- auto open toggleterm
    autocmd({ "BufWinEnter" }, {
      group = augroup("toggleterm", { clear = true }),
      once = true,
      pattern = "*.*",
      callback = function(data)
        -- buffer is help
        local is_help = vim.bo[data.buf].buftype == "help"

        -- buffer is a real file on the disk
        local real_file = vim.fn.filereadable(data.file) == 1

        -- buffer is a [No Name]
        local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

        if not real_file and not no_name then
          return
        elseif is_help then
          return
        end

        -- open the tree and find the file
        require("toggleterm").toggle()
        vim.cmd("stopinsert")
        vim.cmd("wincmd k")
        if vim.fn.has("nvim-tree") then
          if util.auto_open_nvimtree == true then
            require("nvim-tree.api").tree.close()
            require("nvim-tree.api").tree.find_file({ open = true, focus = false })
          end
        end
        vim.cmd("wincmd k")
      end
    })
  end
end

if util.auto_open_nvimtree == true and util.auto_open_toggleterm == false then
  -- auto open nvim-tree from alpha.nvim
  autocmd("FileType", {
    group = augroup("nvim_tree", { clear = true }),
    once = true,
    pattern = "alpha",
    callback = function()
      autocmd("BufWinEnter", {
        once = true,
        pattern = "*.*",
        callback = function()
          if vim.fn.has("nvim-tree") then
            require("nvim-tree.api").tree.close()
            require("nvim-tree.api").tree.find_file({ open = true, focus = false })
            -- vim.cmd("wincmd l")
          end
        end,
      })
    end,
  })
end
