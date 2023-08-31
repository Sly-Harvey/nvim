vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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

-- use: "BufWinEnter"
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("nvim_tree", { clear = true }),
  pattern = "*.*",
  --callback = open_nvim_tree
  callback = open_nvim_tree
})

require("nvim-tree").setup({
    actions = {
      open_file = {
        quit_on_open = false,
      },
    },
    git = {
    enable = true,
    },
    view = {
      adaptive_size = false,
      side = "left",
		  signcolumn = "no",
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
})

vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>')
