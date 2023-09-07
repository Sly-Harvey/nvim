-- disable semantic tokens
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      client.server_capabilities.semanticTokensProvider = nil
    end,
  });

-- auto open nvim-tree
local function open_nvim_tree(data)

    -- buffer is a real file on the disk
    local real_file = vim.fn.filereadable(data.file) == 1
  
    -- buffer is a [No Name]
    local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
  
    if not real_file and not no_name then
      return
    end
  
    -- open the tree, find the file but don't focus it
    require("nvim-tree.api").tree.open()
  end
-- BufWinEnter to focal file
-- BufEnter to focus nvim-tree
vim.api.nvim_create_autocmd({"BufWinEnter"}, {
    group = vim.api.nvim_create_augroup("nvim_tree", { clear = true }),
    once = true,
    pattern = "*.*",
    callback = open_nvim_tree
  })