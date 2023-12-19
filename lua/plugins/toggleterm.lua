return {
    "akinsho/toggleterm.nvim",
    event = { "BufReadPost", "UIEnter", "BufNewFile" },
    cmd = { "ToggleTerm", "TermExec" },
    opts = {
      -- highlights = {
      --   Normal = { link = "Normal" },
      --   NormalNC = { link = "NormalNC" },
      --   NormalFloat = { link = "NormalFloat" },
      --   FloatBorder = { link = "FloatBorder" },
      --   StatusLine = { link = "StatusLine" },
      --   StatusLineNC = { link = "StatusLineNC" },
      --   WinBar = { link = "WinBar" },
      --   WinBarNC = { link = "WinBarNC" },
      -- },
      size = 10,
      on_create = function()
        vim.opt.foldcolumn = "0"
        vim.opt.signcolumn = "no"
      end,
      start_in_insert = true,
      open_mapping = [[<M-f>]],
      shading_factor = 2,
      direction = "horizontal", -- Options: horizontal, float, vertical, tab
      float_opts = { border = "rounded", width = 155, height = 35 },
    },
  }
