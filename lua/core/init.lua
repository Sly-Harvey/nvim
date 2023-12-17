require("core.options")
require("util.functions")
require("core.lazy")
require("core.keymaps")

vim.cmd("colorscheme everforest")
ColorMyPencils("everforest")

local autocmd = vim.api.nvim_create_autocmd

vim.api.nvim_create_augroup('bufcheck', { clear = true })

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
  group = vim.api.nvim_create_augroup('HighlightYank', {}),
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
  group = vim.api.nvim_create_augroup('resize_splits', { clear = true }),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- close with q
autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close-with-q", { clear = true }),
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
  group = vim.api.nvim_create_augroup("wrap_spell", { clear = true }),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- auto open nvim-tree
--autocmd({"BufWinEnter"}, {
--    group = vim.api.nvim_create_augroup("nvim_tree", { clear = true }),
--    once = true,
--    pattern = "*.*",
--    callback = function(data)
--      -- buffer is help
--      local is_help = vim.bo[data.buf].buftype == "help"
--
--      -- buffer is a real file on the disk
--      local real_file = vim.fn.filereadable(data.file) == 1
--
--      -- buffer is a [No Name]
--      local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
--
--      if not real_file and not no_name then
--        return
--      elseif is_help then
--        return
--      end
--
--      -- open the tree and find the file
--      require("nvim-tree.api").tree.open({ find_file = true, focus = true, update_root = true })
--    end
--  })
