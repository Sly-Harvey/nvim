vim.g.mapleader = " "

vim.opt.guicursor = ""

-- Sync clipboards 
vim.opt.clipboard = "unnamedplus"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.fillchars = { eob = " " }

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.isfname:append("@-@")

-- go to previous/next line with h,l,left arrow and right arrow
--vim.opt.whichwrap:append "<>[]hl"

vim.opt.lazyredraw = false
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

--vim.opt.colorcolumn = "80"
