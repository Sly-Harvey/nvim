vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>', { noremap = true, silent = true })

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
