local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                background = { -- :h background
                light = "latte",
                dark = "mocha",
            },
            transparent_background = false, -- disables setting the background color.
            show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
            term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
            dim_inactive = {
                enabled = false, -- dims the background color of inactive window
                shade = "dark",
                percentage = 0.15, -- percentage of the shade to apply to the inactive window
            },
            no_italic = false, -- Force no italic
            no_bold = false, -- Force no bold
            no_underline = false, -- Force no underline
            styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
            comments = { "italic" }, -- Change the style of comments
            conditionals = { "italic" },
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
        },
        color_overrides = {},
        custom_highlights = {},
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            notify = false,
            mini = false,
            indent_blankline = {
                enabled = true,
                colored_indent_levels = false,
            },

            -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
    })
end
  },
  {
      'Mofiqul/vscode.nvim',
      priority = 1000,
      lazy = false,
      config = function()
          local c = require('vscode.colors').get_colors()
          require('vscode').setup({
              -- Alternatively set style in setup
              style = 'dark',

              -- Enable transparent background
              transparent = false,

              -- Enable italic comment
              italic_comments = true,

              -- Disable nvim-tree background color
              disable_nvimtree_bg = true,

              -- Override colors (see ./lua/vscode/colors.lua)
              color_overrides = {
                  --vscLineNumber = '#FFFFFF',
                  vscRed = '#9CDCFE',
              },

              -- Override highlight groups (see ./lua/vscode/theme.lua)
              group_overrides = {
                  -- this supports the same val table as vim.api.nvim_set_hl
                  -- use colors from this colorscheme by requiring vscode.colors!
                  LineNr = { fg = '#858585', bg = c.vscBack },
                  CursorLineNr = { fg = '#C6C6C6', bg = c.vscBack },
                  Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
                  Comment = { fg = c.vscGreen, bg ='NONE', italic = true }
              }
          })
          require('vscode').load()
      end
  },
  {
      'nvim-tree/nvim-tree.lua',
      cmd = { "NvimTreeFindFileToggle", "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse", },
  },
  {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
      },
      config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end,
  },
  { 'nvim-lualine/lualine.nvim', event = "UIEnter", config = function () require('lualine').setup() end },
  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
  'numToStr/FTerm.nvim',
  'nvim-treesitter/playground',
  'ThePrimeagen/harpoon',
  'mbbill/undotree',
  'tpope/vim-fugitive',

  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  -- Lsp stuff
  {
      'neovim/nvim-lspconfig',
      lazy = false,
      dependencies = {
          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/nvim-cmp',
          'L3MON4D3/LuaSnip',
          'hrsh7th/cmp-buffer',
      }
  }
}

local opts = {
    defaults = {lazy = true},
    --install = { colorscheme = { "catppuccin" } },
    performance = {
        rtp = {
            disabled_plugins = {
                "2html_plugin",
                "tohtml",
                "getscript",
                "getscriptPlugin",
                "gzip",
                "logipat",
                "netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                "matchit",
                "tar",
                "tarPlugin",
                "rrhelper",
                "spellfile_plugin",
                "vimball",
                "vimballPlugin",
                "zip",
                "zipPlugin",
                "tutor",
                "rplugin",
                "syntax",
                "synmenu",
                "optwin",
                "compiler",
                "bugreport",
                "ftplugin",
            },
        },
    },
}
require("lazy").setup(plugins, opts)
