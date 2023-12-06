--vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

local keymap = vim.keymap.set

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Open url
vim.keymap.set("n", "<leader>ou", "<esc>:URLOpenUnderCursor<cr>")

-- Nvim-Tree
keymap('n', '<c-n>', ':NvimTreeFindFileToggle<CR>', opts)

-- Telescope
keymap('n', '<leader>cs', "<CMD>Telescope colorscheme<CR>", opts)
keymap('n', '<leader>ff', "<CMD>Telescope find_files<CR>", opts)
keymap('n', '<leader>fr', "<CMD>Telescope oldfiles<CR>", opts)
keymap('n', '<leader>fg', "<CMD>Telescope live_grep<CR>", opts)
keymap('n', '<leader>fw', "<CMD>Telescope grep_string<CR>", opts)
keymap('n', '<leader>fb', "<CMD>Telescope buffers<CR>", opts)
keymap('n', '<leader>sl', "<CMD>Telescope software-licenses find<CR>", opts)
keymap('n', '<leader>fh', "<CMD>Telescope help_tags<CR>", opts)

-- Fterm
keymap('n', '<M-f>', '<CMD>lua require("FTerm").toggle()<CR>', opts)
keymap('t', '<M-f>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Window navigation
keymap('n', '<leader>h', ':nohlsearch<CR>')
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j<CMD>startinsert<CR>", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
keymap("v", "p", '"_dP', opts)
keymap("x", "J", ":m '>+1<CR>gv=gv", opts)
keymap("x", "K", ":m '<-2<CR>gv=gv", opts)
keymap("x", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("x", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', opts)

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", opts)


-- Cargo hotkeys
--keymap('n', '<S-M-F2>', '<CMD>lua require("FTerm").run({"cargo build"})<CR>', opts)
--keymap('n', '<S-M-F3>', '<CMD>lua require("FTerm").run({"cargo build -r"})<CR>', opts)
--keymap('n', '<S-M-F4>', '<CMD>lua require("FTerm").run({"cls && cargo run"})<CR>', opts)
--keymap('n', '<S-M-F5>', '<CMD>lua require("FTerm").run({"cls && cargo run -r"})<CR>', opts)
--keymap('n', '<S-M-F6>', '<CMD>lua require("FTerm").run({"cargo clean"})<CR>', opts)
