local dap, dapui = require("dap"), require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- default rust debug code:
--program = function()
--  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
--end,

--$CWD_FULL/target/debug/$CWD

dap.configurations.rust= {
  {
    name = "Debug",
    type = "codelldb",
    request = "launch",
    program = function()
      require("nvim-tree.api").tree.close()
      require('FTerm').run({ 'cargo', 'build' })
      require('FTerm').toggle()
      vim.cmd('startinsert')
      return vim.fn.getcwd() .. '/target/debug/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    showDisassembly = "never"
  },
}

vim.cmd('stopinsert')
dap.terminate() 
--vim.keymap.set("n", "<Leader>dt", ':DapToggleBreakpoint<CR>')
--vim.keymap.set("n", "<Leader>dx", function() dap.terminate() end)
vim.keymap.set({'n', 'i', 'v', 'x'}, '<F17>', function()
  vim.cmd('stopinsert')
  dap.terminate()
end)

vim.keymap.set('n', '<Leader>dt', function() dapui.toggle() end)
vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('i', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F10>', function() dap.step_over() end)
vim.keymap.set('n', '<F11>', function() dap.step_into() end)
vim.keymap.set('n', '<F12>', function() dap.step_out() end)
vim.keymap.set('i', '<F10>', function() dap.step_over() end)
vim.keymap.set('i', '<F11>', function() dap.step_into() end)
vim.keymap.set('i', '<F12>', function() dap.step_out() end)
vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() dap.set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)