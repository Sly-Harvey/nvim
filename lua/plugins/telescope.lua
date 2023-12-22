return {
  'nvim-telescope/telescope.nvim',
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "chip/telescope-software-licenses.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
  },
  config = function()
    local actions = require("telescope.actions")
    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<S-j>"] = actions.move_selection_next,
            ["<S-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
            -- even more opts
          }
          -- pseudo code / specification for writing custom displays, like the one
          -- for "codeactions"
          -- specific_opts = {
          --   [kind] = {
          --     make_indexed = function(items) -> indexed_items, width,
          --     make_displayer = function(widths) -> displayer
          --     make_display = function(displayer) -> function(e)
          --     make_ordinal = function(e) -> string
          --   },
          --   -- for example to disable the custom builtin "codeactions" display
          --      do the following
          --   codeactions = false,
          -- }
        }
      }
    })
    require('telescope').load_extension('projects')
    require("telescope").load_extension("file_browser")
    require("telescope").load_extension("software-licenses")
  end,
}
