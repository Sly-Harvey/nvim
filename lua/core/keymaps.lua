--vim.g.mapleader = " "
local util = require "util"
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

local keymap = vim.keymap.set

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

keymap("n", "<CR>", "<CR><Cmd>cclose<CR>", { noremap = false, silent = true })
--vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Favorite colourschemes
keymap('', '<A-1>', "<CMD>colorscheme everforest<CR>", opts)
keymap('', '<A-2>', "<CMD>colorscheme kanagawa<CR>", opts)
keymap('', '<A-3>', "<CMD>colorscheme kanagawa-dragon<CR>", opts)
keymap('', '<A-4>', "<CMD>colorscheme vscode<CR>", opts)

-- Lsp
keymap("n", "<leader>gd", vim.lsp.buf.definition, opts)
keymap("n", "<leader>gr", vim.lsp.buf.references, opts)
keymap("n", "<leader>lr", vim.lsp.buf.rename, opts)
keymap("n", "K", vim.lsp.buf.hover, opts)
keymap("n", "J", vim.lsp.buf.code_action, opts)
keymap("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
keymap("n", "<leader>of", vim.diagnostic.open_float, opts)
keymap("n", "[d", vim.diagnostic.goto_next, opts)
keymap("n", "]d", vim.diagnostic.goto_prev, opts)
keymap("i", "<C-h>", vim.lsp.buf.signature_help, opts)
keymap("n", "<leader>fm", function()
  vim.lsp.buf.format { async = true }
end, opts)

-- Hop
if vim.fn.has("Hop") then
  keymap('', '<leader>f', "<CMD>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true })<CR>", opts)
  keymap('', '<leader>F', "<CMD>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true })<CR>", opts)
  keymap('', '<leader>t', "<CMD>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }<CR>)", opts)
  keymap('', '<leader>T', "<CMD>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<CR>", opts)
  keymap('', '<leader>hw', "<CMD>lua require('hop').hint_words()<CR>", opts)
  keymap('', '<leader>hc', "<CMD>lua require('hop').hint_char2()<CR>", opts)
  keymap('', '<leader>gl', "<CMD>lua require('hop').hint_lines_skip_whitespace()<CR>", opts)
end

-- Open url
keymap("n", "<leader>ou", "<esc>:URLOpenUnderCursor<cr>", opts)

-- Nvim-Tree and toggleterm
if vim.g.auto_open_nvimtree == false or vim.g.auto_open_toggleterm == false then
  keymap('n', '<c-n>', ':NvimTreeFindFileToggle<CR>', opts)
  keymap('n', '<M-f>', '<CMD>lua require("toggleterm").toggle()<CR>', opts)
  keymap('t', '<M-f>', '<C-\\><C-n><CMD>lua require("toggleterm").toggle()<CR>', opts)
elseif vim.g.auto_open_nvimtree == true and vim.g.auto_open_toggleterm == true then
  keymap('n', '<c-n>', function ()
    util.toggle_nvimtree_and_toggleterm()
  end, opts)
  keymap('n', '<M-f>', function ()
    util.toggle_nvimtree_and_toggleterm()
  end, opts)
  keymap('t', '<M-f>', function ()
    util.toggle_nvimtree_and_toggleterm()
  end, opts)
end

-- ToggleTerm
-- if vim.fn.has("toggleterm") then
--   keymap('n', '<M-f>', '<CMD>lua require("toggleterm").toggle()<CR>', opts)
--   keymap('t', '<M-f>', '<C-\\><C-n><CMD>lua require("toggleterm").toggle()<CR>', opts)
--
--   if vim.g.auto_open_toggleterm == false then
--     vim.keymap.set('t', '<C-c>', '<C-c><CMD>lua require("toggleterm").toggle()<CR>', opts)
--   end
-- end

-- Fterm
-- keymap('n', '<M-f>', '<CMD>lua require("FTerm").toggle()<CR>', opts)
-- keymap('t', '<M-f>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)

-- Telescope
keymap("n", "<leader>e", "<CMD>Telescope file_browser select_buffer=true<CR>", opts)
keymap('n', '<leader>cs', "<CMD>Telescope colorscheme<CR>", opts)
keymap('n', '<leader>ff', "<CMD>Telescope find_files<CR>", opts)
keymap('n', '<leader>fr', "<CMD>Telescope oldfiles<CR>", opts)
keymap('n', '<leader>fg', "<CMD>Telescope live_grep<CR>", opts)
keymap('n', '<leader>fz', "<CMD>Telescope current_buffer_fuzzy_find<CR>", opts)
keymap('n', '<leader>fw', "<CMD>Telescope grep_string<CR>", opts)
keymap('n', '<leader>fb', "<CMD>Telescope buffers<CR>", opts)
keymap('n', '<leader>sl', "<CMD>Telescope software-licenses find<CR>", opts)
keymap('n', '<leader>fh', "<CMD>Telescope help_tags<CR>", opts)

-- Copy all
keymap("n", "<C-c>a", "<cmd> %y+ <CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Window navigation
keymap('n', '<leader>h', ':nohlsearch<CR>')
keymap("n", "<C-h>", "<C-w><C-h>", opts)
keymap("n", "<C-j>", "<C-w><C-j><CMD>startinsert<CR>", opts)
keymap("n", "<C-k>", "<C-w><C-k>", opts)
keymap("n", "<C-l>", "<C-w><C-l>", opts)

-- Terminal (horizontal)
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k<C-w>l", term_opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

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
