local opt = vim.opt
local util = require("util")

util.auto_open_nvimtree = false
util.auto_open_toggleterm = false
util.colorscheme = "everforest"

vim.g.mapleader = " "

opt.guicursor = ""

-- Sync clipboards 
opt.clipboard = "unnamedplus"

opt.nu = true
opt.relativenumber = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.fillchars = { eob = " " }

opt.ignorecase = true
opt.smartcase = true

opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undofile = true

opt.hlsearch = true
opt.incsearch = true

opt.termguicolors = true

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.isfname:append("@-@")

-- go to previous/next line with h,l,left arrow and right arrow
--opt.whichwrap:append "<>[]hl"

opt.lazyredraw = false
opt.updatetime = 250
opt.timeoutlen = 300

--opt.colorcolumn = "80"
