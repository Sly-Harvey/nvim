-- disable semantic tokens
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      client.server_capabilities.semanticTokensProvider = nil
    end,
  });

-- auto open nvim-tree
vim.api.nvim_create_autocmd({"BufWinEnter"}, {
    group = vim.api.nvim_create_augroup("nvim_tree", { clear = true }),
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
      require("nvim-tree.api").tree.open({ find_file = true, focus = true, update_root = true })
    end
  })

-- close with q
vim.api.nvim_create_autocmd("FileType", {
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

-- Highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-when-yanking", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
