local opt = vim.opt

vim.g.colorscheme = "everforest" -- everforest, vscode, onedark, gruvbox catppuccin, rose-pine, etc.
vim.g.everforest_transparent = false -- set transparency for everforest
vim.g.auto_open_nvimtree = true
vim.g.auto_open_toggleterm = true

vim.g.mapleader = " "
vim.g.max_file = { size = 1024 * 100, lines = 10000 } -- 100 KB

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
opt.fileencoding = "utf-8"
opt.fillchars = { eob = " " }

opt.ignorecase = true
opt.infercase = true
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
opt.updatetime = 300
opt.timeoutlen = 450

--opt.colorcolumn = "80"
