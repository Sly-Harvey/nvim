vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.wo.number = true -- Line numbers
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.laststatus = 2
vim.opt.autoread = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.updatetime = 250
vim.cmd [[ set noswapfile ]]

for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end

--change core/plugin-config/lualine.lua theme after selecting one of the themes below.
--vim.cmd.colorscheme 'tokyonight'
--vim.cmd.colorscheme 'catppuccin'
--vim.cmd.colorscheme 'onedark'
require('vscode').load()
--vim.cmd.colorscheme 'gruvbox'



-- Custom commands

-- FTerm
vim.api.nvim_create_user_command('FTermToggle', function()
    require("FTerm").toggle()
end, { bang = true })

-- Cargo Clean
vim.api.nvim_create_user_command("CargoClean", function()
    require("FTerm").run({"cls && cargo clean"})
end, { bang = true })

-- Cargo Build Debug
vim.api.nvim_create_user_command("CargoBuildDebug", function()
    require("FTerm").run({"cargo build"})
end, { bang = true })

-- Cargo Build Release
vim.api.nvim_create_user_command("CargoBuildRelease", function()
    require("FTerm").run({"cargo build -r"})
end, { bang = true })

-- Cargo Run Debug
vim.api.nvim_create_user_command('CargoRunDebug', function()
    require("FTerm").run({"cls && cargo run"})
end, { bang = true })

-- Cargo Run Release
vim.api.nvim_create_user_command('CargoRunRelease', function()
    require("FTerm").run({"cls && cargo run -r"})
end, { bang = true })