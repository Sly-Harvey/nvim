return {
  'nvim-tree/nvim-tree.lua',
  cmd = { "NvimTreeFindFileToggle", "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse", },
  lazy = true,
  init = function()
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