vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set('n', '<A-n>', ':NvimTreeFindFileToggle<CR>', { noremap = true, silent = true })


--vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true })
--vim.keymap.set("i", "<C-h>", "<Down>", { noremap = true, silent = true })
--vim.keymap.set("i", "<C-h>", "<Up>", { noremap = true, silent = true })
--vim.keymap.set("i", "<C-h>", "<Right>", { noremap = true, silent = true })
--vim.keymap.set("c", "<C-h>", "<Left>", { noremap = true, silent = true })
--vim.keymap.set("c", "<C-h>", "<Down>", { noremap = true, silent = true })
--vim.keymap.set("c", "<C-h>", "<Up>", { noremap = true, silent = true })
--vim.keymap.set("c", "<C-h>", "<Right>", { noremap = true, silent = true })

-- Navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { noremap = true, silent = true })

-- Window navigation
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j<CMD>startinsert<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Move text up and down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "p", '"_dP', { noremap = true, silent = true })
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("x", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("x", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Paste over currently selected text without yanking it
vim.keymap.set("v", "p", '"_dP', { noremap = true, silent = true })

-- Cancel search highlighting with ESC
vim.keymap.set("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", { noremap = true, silent = true })


-- Cargo hotkeys
--vim.keymap.set('n', '<S-M-F2>', '<CMD>lua require("FTerm").run({"cargo build"})<CR>', { noremap = true, silent = true })
--vim.keymap.set('n', '<S-M-F3>', '<CMD>lua require("FTerm").run({"cargo build -r"})<CR>', { noremap = true, silent = true })
--vim.keymap.set('n', '<S-M-F4>', '<CMD>lua require("FTerm").run({"cls && cargo run"})<CR>', { noremap = true, silent = true })
--vim.keymap.set('n', '<S-M-F5>', '<CMD>lua require("FTerm").run({"cls && cargo run -r"})<CR>', { noremap = true, silent = true })
--vim.keymap.set('n', '<S-M-F6>', '<CMD>lua require("FTerm").run({"cargo clean"})<CR>', { noremap = true, silent = true })
