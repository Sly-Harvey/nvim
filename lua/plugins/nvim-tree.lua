vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
    sync_root_with_cwd = true,
    respect_buf_cwd = false,
    update_focused_file = {
      enable = true,
      update_root = true
    },
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
      git_ignored = false, -- Show all .gitignore files
      dotfiles = false, -- Show all dotfiles
    },
})

vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>')
