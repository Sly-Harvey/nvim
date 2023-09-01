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
  -- 'user/repo'
  -- this plugin is required for some other plugins to load.
  { 'nvim-lua/plenary.nvim', event = "UIEnter"},

  -- Themes
  {
    'Mofiqul/vscode.nvim',
    priority = 1000,
    lazy = false,
    config = function() require("themes.vscode") end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    config = function() require("themes.catppuccin") end
  },
  {
    'folke/tokyonight.nvim',
    lazy = true,
    config = function() require("themes.tokyonight") end
  },
  {
    'navarasu/onedark.nvim',
    lazy = true,
    config = function() require("themes.onedark") end
  },
  {
    'ellisonleao/gruvbox.nvim',
    lazy = true,
    config = function() require("themes.gruvbox") end
  },

  -- General
  {
    'goolord/alpha-nvim',
    event = "VimEnter",
    config = function()
      require("plugins.alpha")
    end,
    dependencies = 'nvim-tree/nvim-web-devicons',
  },
  --{
  --  event = "UIEnter",
  --  "ahmedkhalf/project.nvim",
  --  config = function() require("plugins.project") end
  --},
  {
    'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    tag = '0.1.2',
    dependencies = {
      {
        event = "UIEnter",
        "ahmedkhalf/project.nvim",
        config = function() require("plugins.project") end
      },
    },
    config = function()
      require("plugins.telescope")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufAdd",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    config = function() require("plugins.treesitter") end
  },
  { 
    "max397574/better-escape.nvim", 
    event = "InsertCharPre", 
    opts = { timeout = 300 },
    config = function()
      require("plugins.better-escape")
    end
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    event = "BufAdd", --WinNew
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("plugins.bufferline")
    end
  },
  {"dnlhc/glance.nvim", cmd = "Glance"},
  {
    'numToStr/FTerm.nvim',
    cmd = "FTermToggle",
    config = function() require("plugins.fterm") end
  },
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { "NvimTreeFindFileToggle", "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse", },
    init = function() require("plugins.nvim-tree") end,
  },
  {
    'nvim-lualine/lualine.nvim',
    event = "UIEnter",
    config = function()
      require("plugins.lualine")
    end,
  },
  'folke/neodev.nvim',
  'tpope/vim-sleuth',
  

  --Display keymaps
  --{
  --  "folke/which-key.nvim",
  --  event = "VeryLazy",
  --  init = function()
  --    vim.o.timeout = true
  --    vim.o.timeoutlen = 300
  --  end,
  --  opts = {}
  --},
  
  -- Git
  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    ft = { "gitcommit", "diff" },
    config = function() require("plugins.git-signs") end,
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'tpope/vim-fugitive',
      'tpope/vim-rhubarb',
    },
  },
  

  -- Languages
  {
    'simrat39/rust-tools.nvim',
    ft = {
      "rust",
    },
    config = function() require("plugins.rust") end,
  },
  {
    'saecki/crates.nvim',
    tag = 'v0.3.0',
    ft = "toml",
    config = function() require("plugins.crates") end,
  },

  -- Language server protocol
  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    config = function() require("plugins.lsp-config") end,
    dependencies = {
      {
        'williamboman/mason.nvim',
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
      },
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
      'glepnir/lspsaga.nvim',
    },
  },
  

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    config = function() require("plugins.completions") end,
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
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
      {
        'nmac427/guess-indent.nvim',
        config = function() require("plugins.guess-indent") end
      },
      {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
          require("plugins.indent-blankline")
        end,
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
  },
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
