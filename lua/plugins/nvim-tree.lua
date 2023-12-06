return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {'nvim-tree/nvim-web-devicons'},
  lazy = false,
  config = function()
    require("nvim-tree").setup({
      sync_root_with_cwd = false,
      respect_buf_cwd = false,
      update_focused_file = {
        enable = true,
        --update_root = true
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      git = {
      enable = true,
      },
      view = {
        adaptive_size = false,
        preserve_window_proportions = true,
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
  end,
}