local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }


local crates = require('crates')
keymap('n', '<leader>ct', require('crates').toggle, opts)
keymap('n', '<leader>cr', require('crates').reload, opts)
keymap('n', '<leader>cv', require('crates').show_versions_popup, opts)
keymap('n', '<leader>cf', require('crates').show_features_popup, opts)
keymap('n', '<leader>cd', require('crates').show_dependencies_popup, opts)
keymap('n', '<leader>cu', require('crates').update_crate, opts)
keymap('v', '<leader>cu', require('crates').update_crates, opts)
keymap('n', '<leader>ca', require('crates').update_all_crates, opts)
keymap('n', '<leader>cU', require('crates').upgrade_crate, opts)
keymap('v', '<leader>cU', require('crates').upgrade_crates, opts)
keymap('n', '<leader>cA', require('crates').upgrade_all_crates, opts)
keymap('n', '<leader>cH', require('crates').open_homepage, opts)
keymap('n', '<leader>cR', require('crates').open_repository, opts)
keymap('n', '<leader>cD', require('crates').open_documentation, opts)
keymap('n', '<leader>cC', require('crates').open_crates_io, opts)
--keymap('n', '<leader>ce', crates.expand_plain_crate_to_inline_table, opts)
--keymap('n', '<leader>cE', crates.extract_crate_into_table, opts)

crates.setup()